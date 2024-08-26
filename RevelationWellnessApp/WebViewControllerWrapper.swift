import SwiftUI

struct WebViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> WebViewController {
        return WebViewController()
    }

    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {
        // No update necessary for now
    }
}
