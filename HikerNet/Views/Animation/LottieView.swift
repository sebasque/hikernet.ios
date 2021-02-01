
import Foundation
import SwiftUI
import Lottie

// MARK: Animation view for playing animations
struct LottieView: UIViewRepresentable {
    var name: String!
    @Binding var play: Bool
    var loop: Bool
    var animationView = AnimationView()

    class Coordinator: NSObject {
        var parent: LottieView
        init(_ animationView: LottieView) {
            self.parent = animationView
            super.init()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()

        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        if (loop) { animationView.loopMode = .loop }

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        context.coordinator.parent.animationView.play()
    }
    
}
