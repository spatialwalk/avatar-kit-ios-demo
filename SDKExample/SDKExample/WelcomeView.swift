import SwiftUI
import AvatarKit

struct WelcomeView: View {
    @State private var avatarID: String = ""
    @State private var sessionToken: String = ""
    @State private var navigateToContent: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var avatar: Avatar?
    
    private func load() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let id = avatarID.trimmingCharacters(in: .whitespacesAndNewlines)
                avatar = try await AvatarManager.shared.load(id: id) { print("\($0.fractionCompleted)") }
                isLoading = false
                navigateToContent = true
                AvatarSDK.sessionToken = sessionToken
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(spacing: 0) {
                    Text("AvatarKit Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("SDK Driving Service Mode")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Avatar ID")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Link("Test Avatars", destination: URL(string: "https://docs.spatialreal.ai/overview/test-avatars")!)
                            .font(.caption)
                    }
                    .padding(.horizontal, 16)
                    
                    TextField("Enter Avatar ID", text: $avatarID)
                        .font(.system(size: 14))
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.horizontal, 12)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Session Token")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Link("Generator", destination: URL(string: "https://dash.spatialreal.ai")!)
                            .font(.caption)
                    }
                    .padding(.horizontal, 16)
                    
                    TextField("Enter Session Token", text: $sessionToken)
                        .font(.system(size: 14))
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.horizontal, 12)
                }
                
                if let errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal, 12)
                }
                
                Button(action: {
                    load()
                }) {
                    Text(isLoading ? "Loading..." : "Load")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(avatarID.isEmpty || sessionToken.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                }
                .disabled(avatarID.isEmpty || sessionToken.isEmpty || isLoading)
                .padding(.horizontal, 16)
                .padding(.vertical, 50)
                
                Spacer()
            }
            .padding(4)
            .navigationDestination(isPresented: $navigateToContent) {
                if let avatar {
                    ContentView(avatar: avatar)
                }
            }
        }
    }
}
