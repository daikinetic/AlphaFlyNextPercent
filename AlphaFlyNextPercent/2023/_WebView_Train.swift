//
//  _WebView_Train.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/21.
//
//  https://qiita.com/rc_code/items/23109bbb3c073a46eda9
//  https://zenn.dev/dd_sho/articles/f5bbee06133063
//  https://qiita.com/nikadon/items/1a38761012d530db112a

import Foundation
import UIKit
import WebKit
import CoreLocation

final class _WebView_Train: UIViewController {
  var webView: WKWebView!
//  lazy var locationManager: CLLocationManager = { [unowned self] in
//    var manager = CLLocationManager()
//    manager.delegate = self
//    return manager
//  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    let myURL = URL(string: "https://kyome.io/debug/index.html")

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

  // alert
  func webView(
    _ webView: WKWebView,
    runJavaScriptAlertPanelWithMessage message: String,
    initiatedByFrame frame: WKFrameInfo,
    completionHandler: @escaping () -> Void
  ) {
    let alertController = UIAlertController(
      title: "title",
      message: "message",
      preferredStyle: .alert
    )

    let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
      completionHandler()
    })

    alertController.addAction(okAction)

    present(alertController, animated: true, completion: nil)
  }

  // confirm dialog
  func webView(
    _ webView: WKWebView,
    runJavaScriptConfirmPanelWithMessage message: String,
    initiatedByFrame frame: WKFrameInfo,
    completionHandler: @escaping (Bool) -> Void
  ) {
    let alertController = UIAlertController(title: "title", message: "message", preferredStyle: .alert)

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
      completionHandler(false)
    })

    let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
      completionHandler(true)
    })

    alertController.addAction(cancelAction)
    alertController.addAction(okAction)

    present(alertController, animated: true, completion: nil)
  }

  // prompt
  func webView(
    _ webView: WKWebView,
    runJavaScriptTextInputPanelWithPrompt prompt: String,
    defaultText: String?, initiatedByFrame frame: WKFrameInfo,
    completionHandler: @escaping (String?) -> Void
  ) {
    let alertController = UIAlertController(title: "title", message: prompt, preferredStyle: .alert)

    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: { action in
      completionHandler("")
    })

    let okHandler = { () -> Void in
      if let textField = alertController.textFields?.first {
        completionHandler(textField.text)
      } else {
        completionHandler("")
      }
    }

    let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
      okHandler()
    })

    alertController.addTextField() { $0.text = defaultText }
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)

    present(alertController, animated: true, completion: nil)
  }

  // Permission
  func webView(
    _ webView: WKWebView, 
    didReceive challenge: URLAuthenticationChallenge,
    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
  ) {
    print("ユーザー認証")
    completionHandler(.useCredential, nil)
  }

  // 読み込み設定
  // リンクをタップして、ページを読み込む前に呼ばれる
  func webView(
    _ webView: WKWebView,
    decidePolicyFor navigationAction: WKNavigationAction,
    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
  ) {
    print("リクエスト前")

    // WebView 内の特定のリンクをタップした時の処理

    let url = navigationAction.request.url
    print(url ?? "")

    //　読み込み前なので、url をチェックして
    //  AppStore ならストアへ飛ばして、Deeplink ならアプリに戻る、とかができる

    decisionHandler(.allow)

    let alertController = UIAlertController(title: "url", message: "\(url?.description)", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
      //
    })
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }
}

//extension _WebView_Train: CLLocationManagerDelegate {
//  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    switch status {
//    case .notDetermined:
//      locationManager.requestWhenInUseAuthorization()
//    case .restricted, .denied:
//      break
//    case .authorizedAlways, .authorizedWhenInUse:
//      break
//    }
//  }
//}
