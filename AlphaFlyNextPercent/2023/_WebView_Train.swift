//
//  _WebView_Train.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/21.
//
//  https://qiita.com/rc_code/items/23109bbb3c073a46eda9

import Foundation
import UIKit
import WebKit

final class _WebView_Train: UIViewController {
  var webView: WKWebView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let myURL = URL(string: "https://www.apple.com")

    if let myURL = myURL {

      let myRequest = URLRequest(url: myURL)
      webView.load(myRequest)
    }
  }

  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    webView.navigationDelegate = self
    view = webView
  }
}

extension _WebView_Train: WKUIDelegate {
  // delegate
}

extension _WebView_Train: WKNavigationDelegate {
  // delegate
}
