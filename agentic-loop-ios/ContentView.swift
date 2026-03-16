import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SubmitView()
                .tabItem {
                    Label("Submit", systemImage: "heart.fill")
                }

            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
        }
        .preferredColorScheme(.dark)
        .tint(DesignTokens.Colors.accent)
    }
}

#Preview {
    ContentView()
}
