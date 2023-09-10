//
//  ViewController.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/09.
//

import UIKit

class MainTabBarViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear

    setUp()

  }

  func setUp() {

    let firstVC = MondrianOfMondrian()
    firstVC.tabBarItem = UITabBarItem(title: "tab1", image: .actions, tag: 0)

    let secondVC = UIViewController()
    secondVC.tabBarItem = UITabBarItem(title: "tab2", image: .add, tag: 0)
    secondVC.view.backgroundColor = .layeringColor

    viewControllers = [firstVC, secondVC]

  }


}

