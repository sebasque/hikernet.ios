
import SwiftUI
import SafariServices

// MARK: Safari controller wrapper for SwiftUI
struct SafariView: UIViewControllerRepresentable {
    @State var url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}
