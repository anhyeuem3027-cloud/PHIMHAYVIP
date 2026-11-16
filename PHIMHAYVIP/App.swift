
import SwiftUI

@main
struct PHIMHAYVIPApp: App {
    var body: some Scene {
        WindowGroup {
            MovieWebView()
                .ignoresSafeArea(edges: .bottom)
        }
    }
}
