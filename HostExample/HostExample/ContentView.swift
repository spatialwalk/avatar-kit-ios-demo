import SwiftUI
import AvatarKit

struct ContentView: View {
    @StateObject private var viewModel: AvatarViewModel
    
    init(avatar: Avatar, mockData: MockData, sampleRate: Int) {
        _viewModel = StateObject(wrappedValue: AvatarViewModel(
            avatar: avatar,
            mockData: mockData,
            sampleRate: sampleRate
        ))
    }
    
    var body: some View {
        VStack(spacing: 30) {
            AvatarViewRepresentable(avatar: viewModel.avatar) { viewModel.setAvatarController($0) }
                .frame(width: 300, height: 300)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                viewModel.mockPlayback()
            } label: {
                Text("Mock Playback")
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
        }
        .padding(50)
        .onDisappear {
            viewModel.interrupt()
        }
    }
}
