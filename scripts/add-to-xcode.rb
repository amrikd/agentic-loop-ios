#!/usr/bin/env ruby
# Usage: ruby scripts/add-to-xcode.rb path/to/NewFile.swift
#
# Adds a Swift file to the Xcode project and main build target.
# The file must already exist on disk. The path should be relative
# to the project root (e.g. agentic-loop-ios/Views/Submit/SubmitView.swift).

require 'xcodeproj'
require 'pathname'

file_path = ARGV[0]
unless file_path
  puts "Usage: ruby scripts/add-to-xcode.rb <relative-path-to-swift-file>"
  exit 1
end

unless File.exist?(file_path)
  puts "Error: File not found: #{file_path}"
  exit 1
end

project_path = File.join(__dir__, '..', 'agentic-loop-ios.xcodeproj')
project = Xcodeproj::Project.open(project_path)
target = project.targets.find { |t| t.name == 'agentic-loop-ios' } || project.targets.first

# Resolve the file path relative to the project root
project_root = File.expand_path(File.join(__dir__, '..'))
abs_path = File.expand_path(file_path, project_root)
rel_path = Pathname.new(abs_path).relative_path_from(Pathname.new(project_root)).to_s

# Check if file is already in the project
existing = project.files.find { |f| f.real_path.to_s == abs_path || f.path == rel_path }
if existing
  puts "Already in project: #{rel_path}"
  exit 0
end

# Navigate/create group hierarchy matching the directory structure
parts = rel_path.split('/')
filename = parts.pop
group = project.main_group

parts.each do |dir|
  child = group.children.find { |g| g.respond_to?(:name) && (g.name == dir || g.path == dir) }
  if child
    group = child
  else
    group = group.new_group(dir, dir)
  end
end

# Add file reference and to build target
file_ref = group.new_file(abs_path)
target.add_file_references([file_ref])
project.save

puts "Added to Xcode project: #{rel_path}"
