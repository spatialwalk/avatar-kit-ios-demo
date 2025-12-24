import SwiftUI
import Combine
import AvatarKit

@MainActor class AvatarViewModel: ObservableObject {
    @Published var conversationState: String = "\(ConversationState.idle)"
    @Published var errorMessage: String?
    
    let avatar: Avatar
    let mockData: MockData
    let sampleRate: Int
    
    init(avatar: Avatar, mockData: MockData, sampleRate: Int) {
        self.avatar = avatar
        self.mockData = mockData
        self.sampleRate = sampleRate
    }
    
    private var avatarController: AvatarController?
    
    func setAvatarController(_ controller: AvatarController) {
        avatarController = controller
        avatarController?.onConversationState = { [weak self] conversationState in
            self?.conversationState = "\(conversationState)"
        }
        avatarController?.onError = { [weak self] error in
            self?.errorMessage = error.localizedDescription
        }
    }
    
    func mockPlayback() {
        guard let avatarController else { return }
        
        let conversationID = avatarController.yield(
            mockData.audioData,
            end: true,
            audioFormat: AudioFormat(sampleRate: sampleRate)
        )
        
        avatarController.yield(mockData.animationsDataList, conversationID: conversationID)
    }
    
    func interrupt() {
        avatarController?.interrupt()
    }
}
