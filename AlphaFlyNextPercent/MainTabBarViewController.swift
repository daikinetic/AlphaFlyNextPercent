//
//  ViewController.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/09.
//

import UIKit
import MondrianLayout
import UIOnboarding

class MainTabBarViewController: UITabBarController, UIOnboardingViewControllerDelegate {

  @objc func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
    onboardingViewController.modalTransitionStyle = .crossDissolve
    onboardingViewController.dismiss(animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setUp()

  }

  func setUp() {

    let onboardingController: UIOnboardingViewController = .init(withConfiguration: .init(
      appIcon: UIOnboardingHelper.setUpIcon(),
      firstTitleLine: UIOnboardingHelper.setUpFirstTitleLine(),
      secondTitleLine: UIOnboardingHelper.setUpSecondTitleLine(),
      features: UIOnboardingHelper.setUpFeatures(),
      buttonConfiguration: UIOnboardingHelper.setUpButton()
    ))
    onboardingController.delegate = self
    navigationController?.present(onboardingController, animated: false)

    let firstVC = MondrianOfMondrian()
    firstVC.tabBarItem = UITabBarItem(title: "tab1", image: .actions, tag: 0)

    let secondVC = ShimmerPairsCardViewController()
    secondVC.tabBarItem = UITabBarItem(title: "tab2", image: .add, tag: 1)

    let thirdVC = GestureTrainVC()
    thirdVC.tabBarItem = UITabBarItem(title: "tab3", image: .strokedCheckmark, tag: 2)

    let fourceVC = ShimmerStepPairsCardStepViewController()
    fourceVC.tabBarItem = UITabBarItem(title: "tab4", image: .strokedCheckmark, tag: 2)

    let fifthVC = _WebView_Train()
    fifthVC.tabBarItem = UITabBarItem(title: "tab5", image: .strokedCheckmark, tag: 2)


    viewControllers = [thirdVC, secondVC, firstVC, fifthVC]

  }

  final class MockViewController: UIViewController {

    //MARK: - Properties
    private let mockView: UIView = .init()

    //MARK: - Initializer
    init() {
      super.init(nibName: nil, bundle: nil)
      view.backgroundColor = .white

      mockView.backgroundColor = .blue
      mockView.frame = .init(x: 100, y: 100, width: 200, height: 200)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    override func viewDidLoad() {
      Mondrian.buildSubviews(on: view) {
        VStackBlock(alignment: .center) {
          HStackBlock(alignment: .center) {
            mockView
          }
        }
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
        self.mockView.isShimmering = true
      })
    }
  }



}

import UIKit
import UIOnboarding

struct UIOnboardingHelper {
    // App Icon
    static func setUpIcon() -> UIImage {
      return Bundle.main.appIcon ?? .init(named: "mountain")!//.init(named: "onboarding-icon")!
    }

    // First Title Line
    // Welcome Text
    static func setUpFirstTitleLine() -> NSMutableAttributedString {
        .init(string: "Welcome to", attributes: [.foregroundColor: UIColor.label])
    }

    // Second Title Line
    // App Name
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        .init(string: Bundle.main.displayName ?? "Insignia", attributes: [
          .foregroundColor: UIColor.blue
        ])
    }

    // Core Features
    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        return .init([
            .init(icon: .init(named: "mountain")!,
                  title: "Search until found",
                  description: "Over a hundred insignia of the Swiss Armed Forces – each redesigned from the ground up."),
            .init(icon: .init(named: "mountain")!,
                  title: "Enlist prepared",
                  description: "Practice with the app and pass the rank test on the first run."),
            .init(icon: .init(named: "mountain")!,
                  title: "#teamarmee",
                  description: "Add name tags of your comrades or cadre. Insignia automatically keeps every name tag you create in iCloud.")
        ])
    }

    // Notice Text
    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        return .init(icon: .init(named: "onboarding-notice-icon")!,
                     text: "Developed and designed for members of the Swiss Armed Forces.",
                     linkTitle: "Learn more...",
                     link: "https://www.lukmanascic.ch/portfolio/insignia",
                     tint: .init(named: "camou"))
    }

    // Continuation Title
    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "Continue",
                     titleColor: .white, // Optional, `.white` by default
                     backgroundColor: UIColor.blue)
    }
}
