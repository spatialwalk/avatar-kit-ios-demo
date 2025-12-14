import SwiftUI
import Combine
import AvatarKit

@MainActor class AvatarViewModel: ObservableObject {
    // see: https://docs.spatialreal.ai/overview/test-avatars
    private let avatarID: String = ""
    
    @Published var isLoading: Bool = false
    @Published var progress: Double = 0.0
    @Published var errorMessage: String?
    @Published var conversationState: String = "\(ConversationState.idle)"
    
    @Published var avatar: Avatar?
    
    @Published var mockData: MockData?
    
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
    
    func loadMockData() {
        Task {
            do {
                mockData = try await MockDataService.fetch()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func mockPlayback() {
        guard let mockData, let avatarController else { return }
        
        let conversationID = avatarController.yield(mockData.audioData, end: true)
        avatarController.yield(mockData.animationsDataList, conversationID: conversationID)
    }
    
    func interrupt() {
        avatarController?.interrupt()
    }
}

struct MockData: Codable {
    let audio: String
    let animations: [String]
    
    var audioData: Data { Data(base64Encoded: audio)! }
    var animationsDataList: [Data] { animations.map { Data(base64Encoded: $0)! } }
}

enum MockDataService {
    static func fetch() async throws -> MockData {
        let urlString = "https://avatar-sdk-go-test.spatialwalk.cn/media"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
        let mockData = try JSONDecoder().decode(MockData.self, from: data)
        return mockData
    }
}
