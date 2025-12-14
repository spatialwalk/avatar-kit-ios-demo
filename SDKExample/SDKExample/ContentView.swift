import SwiftUI
import AvatarKit

struct ContentView: View {
    @StateObject private var viewModel = AvatarViewModel()
    
    var body: some View {
        if let avatar = viewModel.avatar {
            VStack(spacing: 15) {
                AvatarViewRepresentable(avatar: avatar) { viewModel.setAvatarController($0) }
                    .frame(width: 300, height: 300)
                
                Text("Connection: \(viewModel.connectionState)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Conversation: \(viewModel.conversationState)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button("Start", action: viewModel.start)
                
                Button("Send Audio 1", action: viewModel.sendAudio1)
                
                Button("Send Audio 2+3", action: viewModel.sendAudio2And3)
                
                Button("Interrupt", action: viewModel.interrupt)
                
                Button("Close", action: viewModel.close)
            }.padding(EdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50))
        } else if viewModel.isLoading {
            VStack(spacing: 15) {
                ProgressView(value: viewModel.progress, total: 1.0)
                    .progressViewStyle(.linear)
                    .frame(width: 200)
                
                Text("Loading \(Int(viewModel.progress * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        } else {
            VStack(spacing: 15) {
                Button(action: viewModel.loadAvatar) {
                    Text("Load Avatar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
