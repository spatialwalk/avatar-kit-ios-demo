import SwiftUI
import AvatarKit

@main
struct App: SwiftUI.App {
    init() {
        let configuration = Configuration(
            environment: .intl,
            drivingServiceMode: .host,
            logLevel: .off
        )
        AvatarSDK.initialize(
            appID: "YOUR_APP_ID",
            configuration: configuration
        )
        AvatarSDK.userID = ""
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
