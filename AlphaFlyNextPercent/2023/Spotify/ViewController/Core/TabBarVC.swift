//
//  TabBarVC.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/02/04.
//
//  PART1: https://youtu.be/im5n5gpTHTM?si=Ck5Q4v5745FpGPBM
//  PART2: https://youtu.be/MfhwNT5uT2s?si=tehCwoqvH4f1pYn2 WIP 0:00

import UIKit

final class SpotifyTabBarVC: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let vcs: [UIViewController : (String, String)] = [
      SpotifyHomeVC() : ("Browse", "house"),
      SpotifySearchVC() : ("Search", "magnifyingglass"),
      SpotifyLibraryVC() : ("Library", "music.note.list")
    ]

    var navs: [UINavigationController] = []

    for vc in vcs {
      let _vc = vc.key
      let title = vc.value.0
      let iconName = vc.value.1

      _vc.title = title
      _vc.navigationItem.largeTitleDisplayMode = .always

      let nav = UINavigationController(rootViewController: _vc)
      nav.navigationBar.prefersLargeTitles = true
      nav.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: iconName), tag: 1)
      navs.append(nav)
    }

    setViewControllers(navs, animated: true)
  }

}
