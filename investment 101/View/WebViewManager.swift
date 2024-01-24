import WebKit
import SwiftUI

class WebViewManager: NSObject, ObservableObject, WKScriptMessageHandler {
    static let shared = WebViewManager()
    
    private var webView: WKWebView?
    private var htmlMessageHandler: ((String) -> Void)?
    
    func setupWebView(_ webView: WKWebView) {
        self.webView = webView
        webView.configuration.userContentController.add(self, name: "htmlButtonClicked")
    }
    
    func setupMessageHandler(handler: @escaping (String) -> Void) {
        self.htmlMessageHandler = handler
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let messageBody = message.body as? String else {
            return
        }
        
        if message.name == "htmlButtonClicked" {
            htmlMessageHandler?(messageBody)
        }
    }
    
    func sendHTMLMessage(_ message: String) {
        webView?.evaluateJavaScript("handleMessage('\(message)')") { _, error in
            if let error = error {
                print("Error sending HTML message: \(error)")
            }
        }
    }
    
    func loadURLString(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return
        }

        let request = URLRequest(url: url)
        webView?.load(request)
    }
}
