//
//  _BasicAnimos.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/09.
//

import Foundation
import MondrianLayout
import UIKit

final class BasicAnimos: UIViewController {

  let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
  let squareBlue = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0))
  let buttonPopIn = UIButton(type: .system)
  let buttonDropFromTop = UIButton(type: .system)
  let buttonComeFromLeft = UIButton(type: .system)
  let buttonResetPopIn = UIButton(type: .system)
  let buttonResetDropFromTop = UIButton(type: .system)
  let buttonResetComeFromLeft = UIButton(type: .system)
  var offset = CGPoint(x: 0, y: -500)
  let x: CGFloat = 0, y: CGFloat = 0

  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white
    view.addSubview(squareBlue)

    squareBlue.layer.cornerRadius = 20.0
    squareBlue.backgroundColor = UIColor.blue
    squareBlue.alpha = 0
    squareBlue.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)


    var configurationBase = UIButton.Configuration.gray()
    configurationBase.baseForegroundColor = .blue

    var configurationReset = UIButton.Configuration.gray()
    configurationReset.baseForegroundColor = .red
    configurationReset.title = "Reset"

    buttonPopIn.configuration = configurationBase
    buttonPopIn.setTitle("PopIn", for: .normal)
    buttonPopIn.addTarget(self, action: #selector(PopIn(_:)), for: .touchDown)

    buttonDropFromTop.configuration = configurationBase
    buttonDropFromTop.setTitle("DropFromTop", for: .normal)
    buttonDropFromTop.addTarget(self, action: #selector(DropFromTop(_:)), for: .touchDown)

    buttonComeFromLeft.configuration = configurationBase
    buttonComeFromLeft.setTitle("ComeFromLeft", for: .normal)
    buttonComeFromLeft.addTarget(self, action: #selector(DropFromTop(_:)), for: .touchDown)

    buttonResetPopIn.configuration = configurationReset
    buttonResetPopIn.addTarget(self, action: #selector(Reset(_:)), for: .touchDown)

    buttonResetDropFromTop.configuration = configurationReset
    buttonResetDropFromTop.addTarget(self, action: #selector(ResetDFT(_:)), for: .touchDown)

    buttonResetComeFromLeft.configuration = configurationReset
    buttonResetComeFromLeft.addTarget(self, action: #selector(ResetCFL(_:)), for: .touchDown)

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        squareBlue
          .viewBlock.padding(50)
        VStackBlock(spacing: 16, alignment: .center) {
          HStackBlock(spacing: 10, alignment: .center) {
            buttonPopIn
            buttonResetPopIn
          }
          HStackBlock(spacing: 10, alignment: .center) {
            buttonDropFromTop
            buttonResetDropFromTop
          }
          HStackBlock(spacing: 10, alignment: .center) {
            buttonComeFromLeft
            buttonResetComeFromLeft
          }
        }

      }
      .size(
        width: LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width),
        height: LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width)
      )
      .padding(.vertical, 100)

    }
  }
}

//MARK: PopUp
extension BasicAnimos {
  @objc func PopIn(_ sender: UIButton) {
    UIView.animate(
      withDuration: 0.5,
      delay: 1,
      usingSpringWithDamping: 0.55,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.squareBlue.transform = .identity
        self.squareBlue.alpha = 1
      },
      completion: nil
    )
  }

  @objc func DropFromTop(_ sender: UIButton) {

    UIView.animate(
      withDuration: 1,
      delay: 1,
      usingSpringWithDamping: 0.47,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.squareBlue.transform = .identity
        self.squareBlue.alpha = 1
      },
      completion: nil
    )
  }
}

//MARK: Reset
extension BasicAnimos {

  @objc func Reset(_ sender: UIButton) {
    UIView.animate(
      withDuration: 0.5,
      delay: 1,
      usingSpringWithDamping: 0.55,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.squareBlue.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.squareBlue.alpha = 0
      },
      completion: nil
    )
  }

  @objc func ResetDFT(_ sender: UIButton) {

    UIView.animate(
      withDuration: 0.5,
      delay: 1,
      usingSpringWithDamping: 0.55,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.offset = CGPoint(x: 0, y: -500)
        self.squareBlue.alpha = 0
        self.squareBlue.transform = CGAffineTransform(translationX: self.offset.x + self.x, y: self.offset.y + self.y)
        self.squareBlue.isHidden = false
      },
      completion: nil
    )
  }

  @objc func ResetCFL(_ sender: UIButton) {

    UIView.animate(
      withDuration: 1,
      delay: 1,
      usingSpringWithDamping: 0.47,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.offset = CGPoint(x: -500, y: 0)
        self.squareBlue.alpha = 0
        self.squareBlue.transform = CGAffineTransform(translationX: self.offset.x + self.x, y: self.offset.y + self.y)
        self.squareBlue.isHidden = false
      },
      completion: nil
    )
  }

}
