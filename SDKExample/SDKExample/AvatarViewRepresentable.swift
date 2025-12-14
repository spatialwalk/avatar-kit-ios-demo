import SwiftUI
import AvatarKit

struct AvatarViewRepresentable: UIViewRepresentable {
    let avatar: Avatar
    let onCreated: (AvatarController) -> Void
    
    func makeUIView(context: Context) -> AvatarView {
        let avatarView = AvatarView(avatar: avatar)
        // avatarView.isOpaque = false
        avatarView.setBackgroundImage(UIImage(contentsOfFile: Bundle.main.path(forResource: "background", ofType: "jpeg")!))
        onCreated(avatarView.avatarController)
        return avatarView
    }
    
    func updateUIView(_ uiView: AvatarView, context: Context) {}
}
