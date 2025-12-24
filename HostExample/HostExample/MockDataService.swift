import Foundation

struct MockData: Codable {
    private let audio_base64: String
    private let animation_messages_base64: [String]
    
    var audioData: Data { Data(base64Encoded: audio_base64)! }
    var animationsDataList: [Data] { animation_messages_base64.map { Data(base64Encoded: $0)! } }
}

enum MockDataService {
    static func fetch(sampleRate: Int) async throws -> MockData {
        let urlString = "https://python-sdk-mock-demo.spatialwalk.cn/generate"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(["sample_rate": "\(sampleRate)"])
        let (data, _) = try await URLSession.shared.data(for: request)
        let mockData = try JSONDecoder().decode(MockData.self, from: data)
        return mockData
    }
}
