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
      UIColor.red.withAlphaComponent(0.3).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
    gradient.locations = [1, 1, 1]

    gradient.frame = CGRect(
      x: -displayView.bounds.width,
      y: 0,
      width: displayView.bounds.width*3,
      height: displayView.bounds.height
    )
    displayView.layer.mask = gradient

    let locationsAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
    locationsAnimation.fromValue = [0.0, 0.3, 0.3]
    locationsAnimation.toValue = [0.7, 1.0, 1.0]

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
    opacityAnimation.beginTime = 0
    opacityAnimation.duration = 0.1

    let opacityAnimationLatter = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
    opacityAnimationLatter.fromValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(0.6).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    opacityAnimationLatter.toValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    opacityAnimationLatter.beginTime = 0.1
    opacityAnimationLatter.duration = 0.3

    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 0.4
    animationGroup.repeatCount = 1
    animationGroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
    animationGroup.animations = [locationsAnimation, opacityAnimation, opacityAnimationLatter]
    gradient.add(animationGroup, forKey: "shimmer")

  }
}

final class ShimmerStepPairsCardStepViewController: UIViewController {

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
    text.textColor = .white

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

      }
      .width(LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width))
      .padding(.vertical, displayViewPaddingVertical)
      .container(respectingSafeAreaEdges: .vertical)
    }
  }
}

import simd

extension ShimmerStepPairsCardStepViewController {

  @objc func shimmer(_ sender: UIButton) {

    let baseColor = UIColor.white.withAlphaComponent(1)
    let highlightColor = UIColor.white.withAlphaComponent(0.3)

    var interpolatedColors: [Any] {
      let baseColor = baseColor
      let highlightColor = highlightColor
      let numberOfSteps = 30
      let baseColors: [UIColor] = [baseColor, highlightColor, baseColor]
      var colors: [UIColor] = []
      for i in 0..<baseColors.count-1 {
        let lengthOfStep = 1.0 / Float(numberOfSteps)
        let newColors = stride(from: 0.0, to: 1.0, by: lengthOfStep).map {
          baseColors[i].interpolate(with: baseColors[i+1], degree: CGFloat(simd_smoothstep(0.0, 1.0, $0)))
        }
        colors += newColors
      }
      colors.append(baseColors[baseColors.count-1])
      return colors.map { $0.cgColor }
    }

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
    locationsAnimation.fromValue = [0.0, 0.2, 0.2]
    locationsAnimation.toValue = [0.8, 1.0, 1.0]

    gradient.add(locationsAnimation, forKey: "shimmer")

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
    animationGroup.duration = 2
    animationGroup.repeatCount = 1
    animationGroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
    animationGroup.animations = [locationsAnimation]//, opacityAnimation]
    gradient.add(animationGroup, forKey: "shimmer")

  }
}


public extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red: red, green: green, blue: blue, alpha: alpha)
    }

    func interpolate(with secondColor: UIColor, degree: CGFloat) -> UIColor {
        let degree = min(1.0, max(0.0, degree))
        let first = components
        let second = secondColor.components

        let red = (1-degree)*first.red + degree*second.red
        let green = (1-degree)*first.green + degree*second.green
        let blue = (1-degree)*first.blue + degree*second.blue
        let alpha = (1-degree)*first.alpha + degree*second.alpha

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}


final class ShimmerTextureCardViewController: UIViewController {

  private let buttonShimmer = UIButton(type: .system)
  private let displayView: UIView = .init(frame: .init(x: 0, y: 0, width: 164 * 1.618, height: 164))
  private let text: UILabel = .init()
  private let headerText: UILabel = .init()
  private let trailingText: UILabel = .init()
  private let icon: UIImageView = .init()
  private let triangel: UIImageView = .init()
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

    text.text = "PEAR CLUB MEMBER"
    text.font = UIFont(name: "Futura-Medium", size: 17)
    //text.font = .scaledFont(style: .subheadline, weight: .bold)
    text.textColor = .white

    headerText.text = "PearCard"
    headerText.font = UIFont(name: "Futura-Medium", size: 8)
    headerText.textColor = .white

    trailingText.text = "3141 7384 9382 8394"
    trailingText.font = UIFont(name: "Futura-Medium", size: 10)
    trailingText.textColor = .white

    icon.image = .init(named: "nashi")
    icon.contentMode = .scaleAspectFit

    triangel.image = .init(named: "triangle")
    triangel.contentMode = .scaleAspectFit

    //
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {

    super.viewDidLoad()

    let gradient = CAGradientLayer()
    gradient.colors = [
      UIColor.init(hex: "2CD8D5").cgColor,
      UIColor.init(hex: "C5C1FF").cgColor,
      UIColor.init(hex: "FFBAC3").cgColor
    ]

    //background-image: linear-gradient(-225deg, #2CD8D5 0%, #C5C1FF 56%, #FFBAC3 100%);

    gradient.startPoint = CGPoint(x: 0, y: 0.6)
    gradient.endPoint = CGPoint(x: 1, y: 1)
    gradient.locations = [0, 0.56, 1.0]

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

    let backgroundView = UIView.mock(backgroundColor: .white)
    backgroundView.layer.cornerRadius = 16
    backgroundView.layer.borderWidth = 0
    backgroundView.layer.addSublayer(gradient)
    backgroundView.alpha = 0.5

    let textureView = UIImageView()
    textureView.layer.cornerRadius = 16
    textureView.layer.borderWidth = 0
    textureView.image = UIImage(named: "metalic")
    textureView.layer.masksToBounds = true

    Mondrian.buildSubviews(on: displayView) {
      ZStackBlock {
        textureView
          .viewBlock.width(300)
        backgroundView
          .viewBlock.width(200)

        VStackBlock(spacing: 0, alignment: .leading) {

          headerText
            .viewBlock
            .height(20)
            .relative(.top, 16)
            .relative(.leading, 0)

          HStackBlock(spacing: 0, alignment: .center) {
            triangel
              .viewBlock
              .height(10)
              .padding(.leading, -56)
              .padding(.top, 6)

            icon
              .viewBlock
              .height(36)
              .padding(.leading, -78)
          }
          .relative(.leading, 0)
          .padding(.bottom, 0)

          text
            .viewBlock
            .height(30)

        }
        .relative(.leading, 24)
        .relative(.bottom, 16)

        trailingText
          .viewBlock
          .height(20)
          .relative(.top, 16)
          .relative(.trailing, 24)

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
//          .background(textureView)
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
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.red.withAlphaComponent(0.9).cgColor,
      UIColor.red.withAlphaComponent(0.8).cgColor,
      UIColor.red.withAlphaComponent(0.75).cgColor,
      UIColor.red.withAlphaComponent(0.8).cgColor,
      UIColor.red.withAlphaComponent(0.9).cgColor,
      UIColor.red.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.55)
    gradient.locations = [1, 1, 1]

    gradient.frame = CGRect(
      x: -displayView.bounds.width + 25,
      y: 0,
      width: displayView.bounds.width*3 - 10,
      height: displayView.bounds.height
    )
    displayView.layer.mask = gradient

    let locationsAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
    locationsAnimation.fromValue = [0.0, 0.04, 0.07, 0.1, 0.12, 0.14, 0.17, 0.2, 0.24]
    locationsAnimation.toValue = [0.76, 0.8, 0.83, 0.86, 0.88, 0.9, 0.93, 0.96, 0.1]
    locationsAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    locationsAnimation.isRemovedOnCompletion = true

    let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
    opacityAnimation.fromValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
    ]
    opacityAnimation.toValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.red.withAlphaComponent(0.9).cgColor,
      UIColor.red.withAlphaComponent(0.8).cgColor,
      UIColor.red.withAlphaComponent(0.75).cgColor,
      UIColor.red.withAlphaComponent(0.8).cgColor,
      UIColor.red.withAlphaComponent(0.9).cgColor,
      UIColor.red.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    opacityAnimation.beginTime = 0.15
    opacityAnimation.duration = 1.45 //0.6
    opacityAnimation.isRemovedOnCompletion = true
    opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

    let opacityAnimationLatter = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
    opacityAnimationLatter.fromValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.red.withAlphaComponent(0.9).cgColor,
      UIColor.red.withAlphaComponent(0.8).cgColor,
      UIColor.red.withAlphaComponent(0.75).cgColor,
      UIColor.red.withAlphaComponent(0.8).cgColor,
      UIColor.red.withAlphaComponent(0.9).cgColor,
      UIColor.red.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor
    ]
    opacityAnimationLatter.toValue = [
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
      UIColor.white.withAlphaComponent(1).cgColor,
    ]
    opacityAnimationLatter.beginTime = 1.6
    opacityAnimationLatter.duration = 1.2
    opacityAnimationLatter.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    opacityAnimationLatter.repeatCount = 1
    opacityAnimationLatter.isRemovedOnCompletion = true

    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 3.8
    animationGroup.repeatCount = .infinity
//    animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    animationGroup.animations = [locationsAnimation, opacityAnimation, opacityAnimationLatter]
    gradient.add(animationGroup, forKey: "shimmer")

  }
}
