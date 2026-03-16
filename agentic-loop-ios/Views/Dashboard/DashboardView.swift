import SwiftUI

// Build your dashboard UI here. Use PulseAPIClient.shared.getResults() / getHistory() / getComments()
struct DashboardView: View {
    var body: some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: DesignTokens.Spacing.lg) {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(DesignTokens.Colors.accentLight)

                Text("Team Dashboard")
                    .font(DesignTokens.Typography.largeTitle)
                    .foregroundStyle(DesignTokens.Colors.textPrimary)

                Text("Build your dashboard UI here.\nUse PulseAPIClient.shared.getResults()\ngetHistory() / getComments()")
                    .font(DesignTokens.Typography.body)
                    .foregroundStyle(DesignTokens.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, DesignTokens.Spacing.xl)
            }
        }
        .navigationTitle("Dashboard")
    }
}

#Preview {
    DashboardView()
}
