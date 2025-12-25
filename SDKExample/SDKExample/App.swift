import SwiftUI
import AvatarKit

@main
struct App: SwiftUI.App {
    init() {
        AvatarSDK.initialize(
            appID: "YOUR_APP_ID",
            configuration: Configuration(
                environment: .intl,
                audioFormat: AudioFormat(sampleRate: 32000),
                drivingServiceMode: .sdk,
                logLevel: .all
            )
        )
        AvatarSDK.userID = ""
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
