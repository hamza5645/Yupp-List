import SwiftUI
import SwiftData

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            mimal_reproducible_example()
        }
        .modelContainer(for: Task.self)
    }
}
