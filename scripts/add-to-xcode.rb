#!/usr/bin/env ruby
# add-to-xcode.rb — Adds new .swift files to the Xcode project so they compile.
#
# Usage:
#   ruby scripts/add-to-xcode.rb
#
# This script scans the agentic-loop-ios/ directory for .swift files that are
# NOT yet referenced in the .pbxproj and adds them to the correct build target.
# Run this after creating new Swift files outside of Xcode (e.g., via Copilot).

require 'xcodeproj'

PROJECT_PATH = File.expand_path('../agentic-loop-ios.xcodeproj', __dir__)
SOURCE_ROOT  = File.expand_path('../agentic-loop-ios', __dir__)
TARGET_NAME  = 'agentic-loop-ios'

project = Xcodeproj::Project.open(PROJECT_PATH)
target  = project.targets.find { |t| t.name == TARGET_NAME }

unless target
  puts "ERROR: Target '#{TARGET_NAME}' not found in project."
  exit 1
end

# Collect all .swift files already in the target's compile sources
known_paths = target.source_build_phase.files.map { |f|
  f.file_ref&.real_path&.to_s
}.compact

added = 0

Dir.glob(File.join(SOURCE_ROOT, '**', '*.swift')).each do |swift_file|
  next if known_paths.include?(swift_file)

  # Determine the Xcode group from the file's directory relative to SOURCE_ROOT
  relative_dir  = File.dirname(swift_file).sub(SOURCE_ROOT, '').sub(%r{^/}, '')
  relative_path = swift_file.sub(SOURCE_ROOT + '/', '')

  # Find or create the group hierarchy
  group = project.main_group.find_subpath('agentic-loop-ios', true)
  relative_dir.split('/').each do |part|
    next if part.empty?
    child = group.children.find { |c| c.display_name == part }
    group = child || group.new_group(part, part)
  end

  # Add file reference and to target
  file_ref = group.new_file(File.basename(swift_file))
  target.source_build_phase.add_file_reference(file_ref)
  added += 1
  puts "  + #{relative_path}"
end

if added > 0
  project.save
  puts "\nAdded #{added} file(s) to '#{TARGET_NAME}' target."
else
  puts "All .swift files are already in the project. Nothing to add."
end
