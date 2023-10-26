//
//  _CAGradientLayer.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/26.
//
//  https://medium.com/swlh/how-to-create-a-custom-gradient-in-swift-with-cagradientlayer-ios-swift-guide-190941cb3db2

import Foundation
import UIKit
import MondrianLayout

final class LinearGradientController: UIViewController {

  lazy var linearGradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.type = .axial
    gradient.colors = [
      UIColor.red.cgColor,
      UIColor.purple.cgColor,
      UIColor.cyan.cgColor
    ]
    gradient.locations = [0, 0.25, 1]
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 1, y: 1)
    return gradient
  }()

  lazy var radialGradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.type = .radial
    gradient.colors = [
      UIColor.purple.cgColor,
      UIColor.blue.cgColor,
      UIColor.green.cgColor,
      UIColor.yellow.cgColor,
      UIColor.orange.cgColor,
      UIColor.red.cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
    let endY = 0.5 + view.frame.size.width / view.frame.size.height / 2
    gradient.endPoint = CGPoint(x: 1, y: endY)
    return gradient
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    linearGradient.frame = view.bounds
    view.layer.addSublayer(linearGradient)
  }

}

final class RadialGradientController: UIViewController {

  lazy var linearGradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.type = .axial
    gradient.colors = [
      UIColor.red.cgColor,
      UIColor.purple.cgColor,
      UIColor.cyan.cgColor
    ]
    gradient.locations = [0, 0.25, 1]
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 1, y: 1)
    return gradient
  }()

  lazy var radialGradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.type = .radial
    gradient.colors = [
      UIColor.init(hex: "D16BA5").cgColor,
      UIColor.init(hex: "86A8E7").cgColor,
      UIColor.init(hex: "5FFBF1").cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
    let endY = 0.5 + view.frame.size.width / view.frame.size.height / 2
    gradient.endPoint = CGPoint(x: 1, y: endY)
    return gradient
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    radialGradient.frame = view.bounds
    view.layer.addSublayer(radialGradient)
  }

}


final class AnimatedGradientController: UIViewController {

  let newColors = [
    UIColor.purple.cgColor,
    UIColor.red.cgColor,
    UIColor.orange.cgColor
  ]

  lazy var linearGradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.type = .axial
    gradient.colors = [
      UIColor.red.cgColor,
      UIColor.purple.cgColor,
      UIColor.cyan.cgColor
    ]
    gradient.locations = [0, 0.25, 1]
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 1, y: 1)
    return gradient
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    linearGradient.frame = view.bounds
    view.layer.addSublayer(linearGradient)

    linearGradient.setColors(
      newColors,
      animated: true,
      withDuration: 2,
      timingFunctionName: .easeInEaseOut
    )
  }
}

private final class MyGradientView: UIView {
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
}

extension CAGradientLayer {

  func setColors(
    _ newColors: [CGColor],
    animated: Bool = true,
    withDuration duration: TimeInterval = 0,
    timingFunctionName name: CAMediaTimingFunctionName? = nil
  ) {
    
    if !animated {
      self.colors = newColors
      return
    }

    let colorAnimation = CABasicAnimation(keyPath: "colors")
    colorAnimation.fromValue = colors
    colorAnimation.toValue = newColors
    colorAnimation.duration = duration
    colorAnimation.isRemovedOnCompletion = false
    colorAnimation.fillMode = CAMediaTimingFillMode.forwards
    colorAnimation.timingFunction = CAMediaTimingFunction(name: name ?? .linear)

    add(colorAnimation, forKey: "colorsChangeAnimation")
  }
}

extension UIColor {
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    let v = Int("000000" + hex, radix: 16) ?? 0
    let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
    let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
    let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
    self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
  }
}

