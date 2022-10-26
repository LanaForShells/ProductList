import SwiftUI

@main
struct ProductListApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
#if DEBUG
                .onAppear(perform: {
                    guard CommandLine.arguments.contains("–uitesting") else { return }
                    UITestingNetworkHandler.register()
                })
#endif
        }
    }
}
