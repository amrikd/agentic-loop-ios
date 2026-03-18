import SwiftUI

// Build your mood submission UI here.
// What to build:
//  - API client (implement PulseAPIClient in Services/PulseAPIClient.swift)
//  - Mood selector (5 buttons, 1=bad to 5=great)
//  - Optional comment TextField (max 280 chars)
//  - Submit button with loading state
//  - Success/error feedback
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

                Text("Build your API client and submit mood UI here.")
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
