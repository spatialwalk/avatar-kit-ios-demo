import SwiftUI
import AvatarKit

struct ContentView: View {
    @StateObject private var viewModel: AvatarViewModel
    
    init(avatar: Avatar) {
        _viewModel = StateObject(wrappedValue: AvatarViewModel(avatar: avatar))
    }
    
    var body: some View {
        VStack(spacing: 15) {
            AvatarViewRepresentable(avatar: viewModel.avatar) { viewModel.setAvatarController($0) }
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
            
            Button {
                viewModel.start()
            } label: {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button {
                viewModel.send()
            } label: {
                Text("Send")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button {
                viewModel.interrupt()
            } label: {
                Text("Interrupt")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button {
                viewModel.close()
            } label: {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding(50)
        .onDisappear {
            viewModel.close()
        }
    }
}
