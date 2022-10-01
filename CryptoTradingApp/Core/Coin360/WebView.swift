//
//  Webview.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 01/10/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
 
    var url: String
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: url) else{
            print("invalid webview url")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
