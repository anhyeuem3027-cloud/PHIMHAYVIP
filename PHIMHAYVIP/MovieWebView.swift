
import SwiftUI
import WebKit

struct MovieWebView: UIViewRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {

        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let web = WKWebView(
            frame: .zero,
            configuration: config
        )

        web.navigationDelegate = context.coordinator
        web.uiDelegate = context.coordinator

        web.allowsBackForwardNavigationGestures = true

        let url = URL(
            string: "https://phimhayvip.io.vn"
        )!

        web.load(URLRequest(url: url))

        return web
    }

    func updateUIView(
        _ uiView: WKWebView,
        context: Context
    ) {}

    class Coordinator: NSObject,
        WKNavigationDelegate,
        WKUIDelegate {

        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {

            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }

            if navigationAction.targetFrame == nil {
                webView.load(URLRequest(url: url))
                decisionHandler(.cancel)
                return
            }

            if ["https", "http"].contains(url.scheme ?? "") {
                decisionHandler(.allow)
            } else {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
            }
        }

        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {

            if let url = navigationAction.request.url {
                webView.load(URLRequest(url: url))
            }

            return nil
        }
    }
}
