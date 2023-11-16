//
//  _CoreAnimo.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/16.
//
//  https://techlife.cookpad.com/entry/2015/10/02/180247

import Foundation
import MondrianLayout
import UIKit

final class _CoreAnimos: UIViewController {

  let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
  let replicatorLayer = CAReplicatorLayer()
  let circle = CALayer()

  //MARK: DisplayButton
  let buttonPopIn = UIButton(type: .system)
  let buttonPopOut = UIButton(type: .system)


  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white

    var configurationBase = UIButton.Configuration.gray()
    configurationBase.baseForegroundColor = .blue

    //MARK: DisplayButton
    buttonPopIn.configuration = configurationBase
    buttonPopIn.setTitle("UpDown", for: .normal)
    buttonPopIn.addTarget(self, action: #selector(startAnimation(_:)), for: .touchDown)

    buttonPopOut.configuration = configurationBase
    buttonPopOut.setTitle("Rotate", for: .normal)
    buttonPopOut.addTarget(self, action: #selector(startAnimo(_:)), for: .touchDown)

    replicatorLayer.frame = view.bounds
    view.layer.addSublayer(replicatorLayer)

    circle.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
    circle.position = view.center
    circle.position.x -= 60
    circle.backgroundColor = UIColor.mondrianCyan.cgColor
    circle.cornerRadius = 15

    replicatorLayer.addSublayer(circle)
    replicatorLayer.instanceCount = 4
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(60, 0.0, 0.0)
    replicatorLayer.instanceDelay = 0.1

//    let animation = CABasicAnimation(keyPath: "position.y")
//    animation.toValue = view.center.y + 20
//    animation.duration = 0.5
//    animation.autoreverses = true
//    animation.repeatCount = .infinity
//    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//    circle.add(animation, forKey: "animation")
//
//    replicatorLayer.instanceDelay = 0.1
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        VStackBlock(spacing: 16, alignment: .center) {
          HStackBlock(spacing: 10, alignment: .center) {
            buttonPopIn
            buttonPopOut
          }
          .spacingBefore(350)
        }
      }
      .size(
        width: LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width),
        height: LayoutDescriptor.ConstraintValue(floatLiteral: 600)
      )
      .padding(.top, 100)

    }
  }
}

//MARK:
extension _CoreAnimos {
  @objc func startAnimation(_ sender: UIButton) {

    circle.removeAllAnimations()
    replicatorLayer.removeAllAnimations()

    let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
    animation.fromValue = CGPoint(x: view.center.x - 80, y: view.center.y)
    animation.toValue = CGPoint(x: view.center.x - 80, y: view.center.y + 20)
    animation.duration = 0.5
    animation.autoreverses = true
    animation.repeatCount = .infinity
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    circle.add(animation, forKey: "animation")
  }

  @objc func startAnimo(_ sender: UIButton) {

    circle.removeAllAnimations()

    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.toValue = 0.8
    scaleAnimation.duration = 0.5
    scaleAnimation.autoreverses = true
    scaleAnimation.repeatCount = .infinity
    scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    circle.backgroundColor = UIColor.green.cgColor
    circle.add(scaleAnimation, forKey: "scaleAnimation")

    // replicatorLayerの回転アニメーション
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.toValue = -2.0*M_PI
    rotationAnimation.duration = 6.0
    rotationAnimation.repeatCount = .infinity
    rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
    replicatorLayer.add(rotationAnimation, forKey: "rotationAnimation")

    replicatorLayer.instanceCount = 8
    replicatorLayer.instanceDelay = 0.1
    var angle = (2.0*M_PI)/Double(replicatorLayer.instanceCount)
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
  }

}

