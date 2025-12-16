import SwiftUI
import AvatarKit

@main
struct App: SwiftUI.App {
    init() {
        let configuration = Configuration(
            environment: .intl,
            drivingServiceMode: .sdk,
            logLevel: .off
        )
        AvatarSDK.initialize(
            appID: "YOUR_APP_ID",
            configuration: configuration
        )
        AvatarSDK.sessionToken = ""
        AvatarSDK.userID = ""
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
