import SwiftUI
import AvatarKit

@main
struct App: SwiftUI.App {
    init() {
        AvatarSDK.initialize(
            appID: "YOUR_APP_ID",
            configuration: Configuration(
                environment: .intl,
                audioFormat: AudioFormat(sampleRate: 16000),
                drivingServiceMode: .host,
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
