import SwiftUI
import Combine
import AvatarKit

@MainActor class AvatarViewModel: ObservableObject {
    // see: https://docs.spatialreal.ai/overview/test-avatars
    private let avatarID: String = ""
    
    @Published var isLoading: Bool = false
    @Published var progress: Double = 0.0
    @Published var errorMessage: String?
    @Published var connectionState: String = "\(ConnectionState.disconnected)"
    @Published var conversationState: String = "\(ConversationState.idle)"
    
    @Published var avatar: Avatar?
    
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
    
    func loadAvatar() {
        progress = 0.0
        errorMessage = nil
        
        if let cachedAvatar = AvatarManager.shared.retrieve(id: avatarID) {
            avatar = cachedAvatar
            Task.detached(priority: .background) { [weak self] in
                guard let self else { return }
                _ = try await AvatarManager.shared.load(id: avatarID)
            }
        } else {
            Task(priority: .userInitiated) {
                do {
                    isLoading = true
                    defer { isLoading = false }
                    avatar = try await AvatarManager.shared.load(id: avatarID) { [weak self] progressInfo in
                        self?.progress = progressInfo.fractionCompleted
                    }
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func start() {
        avatarController?.start()
    }
    
    func sendAudio1() {
        let audioData1 = try! Data(contentsOf: Bundle.main.url(forResource: "audio_01", withExtension: "pcm")!)
        avatarController?.send(audioData1, end: true)
    }
    
    func sendAudio2And3() {
        let audioData2 = try! Data(contentsOf: Bundle.main.url(forResource: "audio_02", withExtension: "pcm")!)
        avatarController?.send(audioData2, end: false)
        
        let audioData3 = try! Data(contentsOf: Bundle.main.url(forResource: "audio_03", withExtension: "pcm")!)
        avatarController?.send(audioData3, end: true)
    }
    
    func interrupt() {
        avatarController?.interrupt()
    }
    
    func close() {
        avatarController?.close()
    }
}
