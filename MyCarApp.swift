
import SwiftUI
import SwiftData

@main
struct MyCarApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack { RootTabs() }
                .modelContainer(AppModelContainer.shared)
                .task { await seedIfNeeded() }
        }
    }
}
