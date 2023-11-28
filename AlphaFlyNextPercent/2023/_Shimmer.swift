//
//  _Shimmer.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/27.
//

import Foundation
import UIKit
import MondrianLayout

final class ShimmerViewController: UIViewController {

  private let buttonShimmer = UIButton(type: .system)
  private let displayView: UIView = .init(frame: .init(x: 0, y: 0, width: 164, height: 64))
  private let text: UILabel = .init()
  let safeAreaInsetsVertical: CGFloat = 59 + 34
  let containerPadding: CGFloat = 20
  let buttonHeight: CGFloat = 50

  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white

    var configurationBase = UIButton.Configuration.gray()
//    configurationBase.baseBackgroundColor = .blue
    configurationBase.baseForegroundColor = .white

    buttonShimmer.configuration = configurationBase
    buttonShimmer.setTitle("Shimmer", for: .normal)
    buttonShimmer.addTarget(self, action: #selector(shimmer(_:)), for: .touchDown)

    displayView.backgroundColor = .init(hex: "18AE9F")
    displayView.layer.cornerRadius = .init(32)

    text.text = "some text"
    text.font = .scaledFont(style: .caption1, weight: .bold)
    text.textColor = .white

    //
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {

    super.viewDidLoad()

    let displayViewPaddingVertical = ((
      view.bounds.height - displayView.frame.height - buttonHeight - safeAreaInsetsVertical - 180 - containerPadding * 2
    )) / 2
    print("QQQ: \(displayViewPaddingVertical)")

    Mondrian.buildSubviews(on: displayView) {
      VStackBlock {
        text
      }
    }

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {

        displayView
          .viewBlock
          .size(
            width: LayoutDescriptor.ConstraintValue(floatLiteral: displayView.frame.width),
            height: LayoutDescriptor.ConstraintValue(floatLiteral: displayView.frame.height)
          )
          .padding(.bottom, 180)

        buttonShimmer
          //.viewBlock
          //.height(LayoutDescriptor.ConstraintValue(floatLiteral: buttonShimmer.frame.height))

      }
      //.padding(.horizontal, containerPadding)
      .width(LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width))
      .padding(.vertical, displayViewPaddingVertical)
      .container(respectingSafeAreaEdges: .vertical)
    }
  }

  @objc func shimmer(_ sender: UIButton) {

    print("QQQ: shimmer")

    let gradient = CAGradientLayer()
    gradient.colors = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(0.3).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.43)
    gradient.locations = [1, 1, 1]

    gradient.frame = CGRect(
      x: -displayView.bounds.width/2,
      y: 0,
      width: displayView.bounds.width*2,
      height: displayView.bounds.height
    )
    displayView.layer.mask = gradient

    let locationsAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
    locationsAnimation.fromValue = [0.0, 0.2, 0.2]
    locationsAnimation.toValue = [0.8, 1.0, 1.0]

    let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
    opacityAnimation.fromValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    opacityAnimation.toValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(0.3).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]

    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 0.4
    animationGroup.repeatCount = 1
    animationGroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
    animationGroup.animations = [locationsAnimation, opacityAnimation]
    gradient.add(animationGroup, forKey: "shimmer")

  }
}


final class ShimmerCardViewController: UIViewController {

  private let buttonShimmer = UIButton(type: .system)
  private let displayView: UIView = .init(frame: .init(x: 0, y: 0, width: 164 * 1.618, height: 164))
  private let text: UILabel = .init()
  let safeAreaInsetsVertical: CGFloat = 59 + 34
  let containerPadding: CGFloat = 20
  let buttonHeight: CGFloat = 50

  init() {

    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white

    var configurationBase = UIButton.Configuration.gray()
//    configurationBase.baseBackgroundColor = .blue
    configurationBase.baseForegroundColor = .white

    buttonShimmer.configuration = configurationBase
    buttonShimmer.setTitle("Shimmer", for: .normal)
    buttonShimmer.addTarget(self, action: #selector(shimmer(_:)), for: .touchDown)

    displayView.backgroundColor = .init(hex: "18AE9F")
    displayView.layer.masksToBounds = true
    displayView.layer.cornerRadius = .init(16)

    text.text = "CLUB MEMBER"
    text.font = UIFont(name: "Futura-Medium", size: 17)
    //text.font = .scaledFont(style: .subheadline, weight: .bold)
    text.textColor = .white

    //
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {

    super.viewDidLoad()

    let gradient = CAGradientLayer()
    gradient.colors = [
      UIColor.init(hex: "B7A263").cgColor,
      UIColor.init(hex: "D8CBA9").cgColor,
      UIColor.init(hex: "D8CBA9").cgColor,
      UIColor.init(hex: "B7A263").cgColor
    ]
    gradient.startPoint = CGPoint(x: 0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1, y: 0.5)
    gradient.locations = [0, 0.45, 0.55, 1.0]

    gradient.frame = CGRect(
      x: -displayView.bounds.width/2,
      y: 0,
      width: displayView.bounds.width*2,
      height: displayView.bounds.height
    )
    displayView.layer.addSublayer(gradient)

    let displayViewPaddingVertical = ((
      view.bounds.height - displayView.frame.height - buttonHeight - safeAreaInsetsVertical - 80 - containerPadding * 2
    )) / 2
    print("QQQ: \(displayViewPaddingVertical)")

    Mondrian.buildSubviews(on: displayView) {
      VStackBlock {
        text
          .viewBlock
          .relative(.bottom, 24)
          .relative(.leading, 24)
      }
    }

    let backgroundView = UIView.mock(backgroundColor: .white)
    backgroundView.layer.cornerRadius = 32

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {

        displayView
          .viewBlock
          .size(
            width: LayoutDescriptor.ConstraintValue(floatLiteral: displayView.frame.width),
            height: LayoutDescriptor.ConstraintValue(floatLiteral: displayView.frame.height)
          )
          .background(backgroundView)
          .padding(.bottom, 80)

        buttonShimmer
          //.viewBlock
          //.height(LayoutDescriptor.ConstraintValue(floatLiteral: buttonShimmer.frame.height))

      }
      //.padding(.horizontal, containerPadding)
      .width(LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width))
      .padding(.vertical, displayViewPaddingVertical)
      .container(respectingSafeAreaEdges: .vertical)
    }
  }

  @objc func shimmer(_ sender: UIButton) {

    print("QQQ: shimmer")

    let gradient = CAGradientLayer()
    gradient.colors = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(0.3).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
    gradient.locations = [1, 1, 1]

    gradient.frame = CGRect(
      x: -displayView.bounds.width/2,
      y: 0,
      width: displayView.bounds.width*2,
      height: displayView.bounds.height
    )
    displayView.layer.mask = gradient

    let locationsAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
    locationsAnimation.fromValue = [0.0, 0.22, 0.22]
    locationsAnimation.toValue = [0.78, 1.0, 1.0]

    let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
    opacityAnimation.fromValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    opacityAnimation.toValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(0.6).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]

    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 0.2
    animationGroup.repeatCount = 1
    animationGroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
    animationGroup.animations = [locationsAnimation, opacityAnimation]
    gradient.add(animationGroup, forKey: "shimmer")

  }
}


final class ShimmerPairsCardViewController: UIViewController {

  private let buttonShimmer = UIButton(type: .system)
  private let displayView: UIView = .init(frame: .init(x: 0, y: 0, width: 164 * 1.618, height: 164))
  private let text: UILabel = .init()
  private let icon: UIImageView = .init()
  let safeAreaInsetsVertical: CGFloat = 59 + 34
  let containerPadding: CGFloat = 20
  let buttonHeight: CGFloat = 50

  init() {

    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white

    var configurationBase = UIButton.Configuration.gray()
//    configurationBase.baseBackgroundColor = .blue
    configurationBase.baseForegroundColor = .white

    buttonShimmer.configuration = configurationBase
    buttonShimmer.setTitle("Shimmer", for: .normal)
    buttonShimmer.addTarget(self, action: #selector(shimmer(_:)), for: .touchDown)

    displayView.backgroundColor = .init(hex: "18AE9F")
    displayView.layer.masksToBounds = true
    displayView.layer.cornerRadius = .init(16)

    icon.image = .init(named: "pairs_logo_white")
    icon.contentMode = .scaleAspectFit

    text.text = "CLUB MEMBER"
    text.font = UIFont(name: "Futura-Medium", size: 17)
    //text.font = .scaledFont(style: .subheadline, weight: .bold)
    text.textColor = .white

    //
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {

    super.viewDidLoad()

    let gradient = CAGradientLayer()
    gradient.colors = [
      UIColor.init(hex: "69D5E4").cgColor,
      UIColor.init(hex: "0096A9").cgColor
    ]
    gradient.startPoint = CGPoint(x: 0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1, y: 0.5)
    gradient.locations = [0, 1.0]

    gradient.frame = CGRect(
      x: -displayView.bounds.width/2,
      y: 0,
      width: displayView.bounds.width*2,
      height: displayView.bounds.height
    )
    displayView.layer.addSublayer(gradient)

    let displayViewPaddingVertical = ((
      view.bounds.height - displayView.frame.height - buttonHeight - safeAreaInsetsVertical - 80 - containerPadding * 2
    )) / 2
    print("QQQ: \(displayViewPaddingVertical)")

    Mondrian.buildSubviews(on: displayView) {
      VStackBlock {
        icon
          .viewBlock
          .height(30)
          .relative(.bottom, 24)
          .relative(.leading, -168)
      }
    }

    let backgroundView = UIView.mock(backgroundColor: .white)
    backgroundView.layer.cornerRadius = 16
    backgroundView.layer.borderWidth = 0

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {

        displayView
          .viewBlock
          .size(
            width: LayoutDescriptor.ConstraintValue(floatLiteral: displayView.frame.width),
            height: LayoutDescriptor.ConstraintValue(floatLiteral: displayView.frame.height)
          )
          .background(backgroundView)
          .padding(.bottom, 80)

        buttonShimmer
          //.viewBlock
          //.height(LayoutDescriptor.ConstraintValue(floatLiteral: buttonShimmer.frame.height))

      }
      //.padding(.horizontal, containerPadding)
      .width(LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width))
      .padding(.vertical, displayViewPaddingVertical)
      .container(respectingSafeAreaEdges: .vertical)
    }
  }

  @objc func shimmer(_ sender: UIButton) {

    let gradient = CAGradientLayer()
    gradient.colors = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(0).cgColor, // 0.3
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5) // 0.0, 0.4
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5) //1.0, 0.6
    gradient.locations = [1, 1, 1]

    gradient.frame = CGRect(
      x: 0, // -displayView.bounds.width/2,
      y: 0,
      width: displayView.bounds.width, // displayView.bounds.width*2
      height: displayView.bounds.height
    )
    displayView.layer.mask = gradient

    let locationsAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
    locationsAnimation.fromValue = [0.0, 0.3, 0.3] // [0.0, 0.2, 0.2]
    locationsAnimation.toValue = [0.7, 1.0, 1.0] // [0.8, 1.0, 1.0]
    locationsAnimation.duration = 1.0 // nil
    locationsAnimation.repeatCount = .infinity

    gradient.add(locationsAnimation, forKey: "shimmer")

//    let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
//    opacityAnimation.fromValue = [
//      UIColor.white.withAlphaComponent(1).cgColor,
//      UIColor.white.withAlphaComponent(1).cgColor,
//      UIColor.white.withAlphaComponent(1).cgColor
//    ]
//    opacityAnimation.toValue = [
//      UIColor.white.withAlphaComponent(1).cgColor,
//      UIColor.white.withAlphaComponent(0.6).cgColor, // 0.6
//      UIColor.white.withAlphaComponent(1).cgColor
//    ]
//
//    let animationGroup = CAAnimationGroup()
//    animationGroup.duration = 1 // 0.4
//    animationGroup.repeatCount = 1
//    animationGroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
//    animationGroup.animations = [locationsAnimation, opacityAnimation]
//    gradient.add(animationGroup, forKey: "shimmer")

  }
}


