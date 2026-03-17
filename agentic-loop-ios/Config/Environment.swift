import Foundation

/// App-wide configuration — edit these two lines per environment.
enum AppEnvironment {

    /// Set to `true` to return static mock data instead of hitting the network.
    static let useMock: Bool = false

    /// Base URL for the Pulse API.  No trailing slash.
    static let apiBaseURL: String = "https://agentic-loop-api.vercel.app/api/v1"

    /// Team identifier sent with every request.
    static let teamID: String = "dev-01"
}
