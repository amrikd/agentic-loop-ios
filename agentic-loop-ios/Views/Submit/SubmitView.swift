import SwiftUI

// Build your mood submission UI here. Use PulseAPIClient.shared.submitMood()
struct SubmitView: View {
    var body: some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: DesignTokens.Spacing.lg) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(DesignTokens.Colors.accent)

                Text("Submit Your Mood")
                    .font(DesignTokens.Typography.largeTitle)
                    .foregroundStyle(DesignTokens.Colors.textPrimary)

                Text("Build your mood submission UI here.\nUse PulseAPIClient.shared.submitMood()")
                    .font(DesignTokens.Typography.body)
                    .foregroundStyle(DesignTokens.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, DesignTokens.Spacing.xl)
            }
        }
        .navigationTitle("Submit")
    }
}

#Preview {
    SubmitView()
}
