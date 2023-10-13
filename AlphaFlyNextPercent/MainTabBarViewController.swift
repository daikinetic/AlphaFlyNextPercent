//
//  ViewController.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/09.
//

import UIKit
import MondrianLayout

class MainTabBarViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear

    setUp()

  }

  func setUp() {

    let firstVC = MondrianOfMondrian()
    firstVC.tabBarItem = UITabBarItem(title: "tab1", image: .actions, tag: 0)

    let secondVC = SearchViewController()
    secondVC.tabBarItem = UITabBarItem(title: "tab2", image: .add, tag: 1)
//    secondVC.view.backgroundColor = .layeringColor

    let thirdVC = MockViewController()
    thirdVC.tabBarItem = UITabBarItem(title: "tab3", image: .strokedCheckmark, tag: 2)

    viewControllers = [firstVC, secondVC, thirdVC]

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

