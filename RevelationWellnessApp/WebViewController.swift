import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the WebView
        webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true // Ensure scrolling is enabled
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        // Set constraints for the WebView to respect the safe area
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        // Load the initial URL
        if let url = URL(string: "https://www.revelationwellness.org/app-login/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // Handle navigation decisions
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }

        let mainDomain = "revelationwellness.org"
        let allowedDomains = ["vimeo.com", "google.com", "libsyn.com"]
        let isMainDomain = url.host?.contains(mainDomain) ?? false
        let isAllowedDomain = allowedDomains.contains(where: { url.host?.contains($0) ?? false })

        // Detect if the link is meant to open in a new tab/window
        if navigationAction.targetFrame == nil {
            // Open in the same WebView
            webView.load(URLRequest(url: url))
            decisionHandler(.cancel)
            return
        }
        
        if !isMainDomain && !isAllowedDomain {
            // Open the URL in an external browser
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
