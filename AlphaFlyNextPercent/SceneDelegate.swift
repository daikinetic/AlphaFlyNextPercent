//
//  SceneDelegate.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/09.
//

import UIKit

//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//  var window: UIWindow?
//
//  lazy var deeplinkCoordinator: DeeplinkCoordinatorProtocol = {
//    return DeeplinkCoordinator(handlers: [
//      AccountDeeplinkHandler(rootViewController: self.rootViewController),
//      VideoDeeplinkHandler(rootViewController: self.rootViewController)
//    ])
//  }()
//
//  var rootViewController: MainTabBarViewController? {
//    return window?.rootViewController as? MainTabBarViewController
//  }
//
//  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//
//    guard let windowScene = (scene as? UIWindowScene) else { return }
//    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//    window?.windowScene = windowScene
//    window?.rootViewController = MainTabBarViewController()
//    window?.makeKeyAndVisible()
//  }
//
//  func sceneDidDisconnect(_ scene: UIScene) {
//    // Called as the scene is being released by the system.
//    // This occurs shortly after the scene enters the background, or when its session is discarded.
//    // Release any resources associated with this scene that can be re-created the next time the scene connects.
//    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
//  }
//
//  func sceneDidBecomeActive(_ scene: UIScene) {
//    // Called when the scene has moved from an inactive state to an active state.
//    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//  }
//
//  func sceneWillResignActive(_ scene: UIScene) {
//    // Called when the scene will move from an active state to an inactive state.
//    // This may occur due to temporary interruptions (ex. an incoming phone call).
//  }
//
//  func sceneWillEnterForeground(_ scene: UIScene) {
//    // Called as the scene transitions from the background to the foreground.
//    // Use this method to undo the changes made on entering the background.
//  }
//
//  func sceneDidEnterBackground(_ scene: UIScene) {
//    // Called as the scene transitions from the foreground to the background.
//    // Use this method to save data, release shared resources, and store enough scene-specific state information
//    // to restore the scene back to its current state.
//  }
//
//}
//
//extension SceneDelegate {
//  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//
//    guard let firstUrl = URLContexts.first?.url else { return }
//
//    print(firstUrl.absoluteString)
//    deeplinkCoordinator.handleURL(firstUrl)
//  }
//}
//
//protocol DeeplinkHandlerProtocol {
//  func canOpenURL(_ url: URL) -> Bool
//  func openURL(_ url: URL)
//}
//
//protocol DeeplinkCoordinatorProtocol {
//  @discardableResult
//  func handleURL(_ url: URL) -> Bool
//}
//
//final class DeeplinkCoordinator {
//  let handlers: [DeeplinkHandlerProtocol]
//
//  init(handlers: [DeeplinkHandlerProtocol]) {
//    self.handlers = handlers
//  }
//}
//
//extension DeeplinkCoordinator: DeeplinkCoordinatorProtocol {
//  @discardableResult
//  func handleURL(_ url: URL) -> Bool {
//    guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else { return false }
//
//    handler.openURL(url)
//    return true
//  }
//}
//
//final class AccountDeeplinkHandler: DeeplinkHandlerProtocol {
//  private weak var rootViewController: MainTabBarViewController?
//  init(rootViewController: MainTabBarViewController? = nil) {
//    self.rootViewController = rootViewController
//  }
//
//  // MARK: - DeeplinkHandlerProtocol
//
//  func canOpenURL(_ url: URL) -> Bool {
//    return url.absoluteString == "alpha://account"
//  }
//
//  func openURL(_ url: URL) {
//    guard canOpenURL(url) else { return }
//
//    let viewController = UIViewController()
//    viewController.title = "Account"
//    viewController.view.backgroundColor = .yellow
//    rootViewController?.present(viewController, animated: true)
//  }
//}
//
//final class VideoDeeplinkHandler: DeeplinkHandlerProtocol {
//  private weak var rootViewController: MainTabBarViewController?
//  init(rootViewController: MainTabBarViewController? = nil) {
//    self.rootViewController = rootViewController
//  }
//
//  // MARK: - DeeplinkHandlerProtocol
//
//  func canOpenURL(_ url: URL) -> Bool {
//    return url.absoluteString.hasPrefix("alpha://videos")
//  }
//
//  func openURL(_ url: URL) {
//    guard canOpenURL(url) else { return }
//
//    let viewController = UIViewController()
//    switch url.path {
//    case "/new":
//      viewController.title = "Video Editing"
//      viewController.view.backgroundColor = .orange
//    default:
//      viewController.title = "Video Listing"
//      viewController.view.backgroundColor = .cyan
//    }
//
//    rootViewController?.present(viewController, animated: true)
//  }
//
//}
//
//
//
//
