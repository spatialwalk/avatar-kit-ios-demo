import SwiftUI
import Combine
import AvatarKit

@MainActor class AvatarViewModel: ObservableObject {
    @Published var connectionState: String = "\(ConnectionState.disconnected)"
    @Published var conversationState: String = "\(ConversationState.idle)"
    @Published var errorMessage: String?
    
    let avatar: Avatar
    
    init(avatar: Avatar) {
        self.avatar = avatar
    }
    
    private var avatarController: AvatarController?
    
    func setAvatarController(_ controller: AvatarController) {
        avatarController = controller
        avatarController?.onConnectionState = { [weak self] connectionState in
            self?.connectionState = "\(connectionState)"
        }
        avatarController?.onConversationState = { [weak self] conversationState in
            self?.conversationState = "\(conversationState)"
        }
        avatarController?.onError = { [weak self] error in
            self?.errorMessage = error.localizedDescription
        }
    }
    
    func start() {
        avatarController?.start()
    }
    
    func send() {
        let sampleRate = AvatarSDK.configuration.audioFormat.sampleRate
        let audioData = try! Data(contentsOf: Bundle.main.url(forResource: "audio_\(sampleRate)", withExtension: "pcm")!)
        avatarController?.send(audioData, end: true)
    }
    
    func interrupt() {
        avatarController?.interrupt()
    }
    
    func close() {
        avatarController?.close()
    }
}
