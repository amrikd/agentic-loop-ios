import SwiftUI

// Build your dashboard UI here.
// What to build:
//  - API client (implement PulseAPIClient in Services/PulseAPIClient.swift)
//  - Average mood display
//  - Distribution bar chart
//  - Recent comments feed
//  - Loading and empty states
//  - Refresh mechanism
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

                Text("Build your API client and dashboard UI here.")
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
