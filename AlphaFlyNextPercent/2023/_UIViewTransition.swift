//
//  _UIViewTransition.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/22.
//
//  https://qiita.com/hachinobu/items/57d4c305c907805b4a53

import Foundation
import MondrianLayout
import UIKit

final class _UIViewTransition: UIViewController {

  let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
  let squareBlue = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0))
//  let squareRed = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0))

  //MARK: DisplayButton
  let buttonPopIn = UIButton(type: .system)
  let buttonDropFromTop = UIButton(type: .system)
  let buttonComeFromLeft = UIButton(type: .system)
  let buttonFadeIn = UIButton(type: .system)
  let buttonCardFlip = UIButton(type: .system)
  let buttonTransitionFlipFromLeft = UIButton(type: .system)
  let buttonTransitionFlipFromRight = UIButton(type: .system)
  let buttonTransitionFlipFromTop = UIButton(type: .system)
  let buttonTransitionFlipFromBottom = UIButton(type: .system)
  let buttonTransitionCurlUp = UIButton(type: .system)
  let buttonTransitionCurlDown = UIButton(type: .system)
  let buttonTransitionCurlDownReverse = UIButton(type: .system)



  //MARK: ResetButton
  let buttonResetPopIn = UIButton(type: .system)
  let buttonResetDropFromTop = UIButton(type: .system)
  let buttonResetComeFromLeft = UIButton(type: .system)
  let buttonResetFadeIn = UIButton(type: .system)
  let buttonResetCardFlip = UIButton(type: .system)

  var offset = CGPoint(x: 0, y: -500)
  let x: CGFloat = 0, y: CGFloat = 0

  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white
    view.addSubview(squareBlue)

    squareBlue.layer.cornerRadius = 20.0
    squareBlue.backgroundColor = UIColor.blue
    squareBlue.alpha = 0

//    squareRed.layer.cornerRadius = 20.0
//    squareRed.backgroundColor = UIColor.red

    var configurationBase = UIButton.Configuration.gray()
    configurationBase.baseForegroundColor = .blue

    var configurationReset = UIButton.Configuration.gray()
    configurationReset.baseForegroundColor = .red
    configurationReset.title = "Reset"

    //MARK: DisplayButton
    buttonPopIn.configuration = configurationBase
    buttonPopIn.setTitle("PopIn", for: .normal)
    buttonPopIn.addTarget(self, action: #selector(PopIn(_:)), for: .touchDown)

    buttonDropFromTop.configuration = configurationBase
    buttonDropFromTop.setTitle("DropFromTop", for: .normal)
    buttonDropFromTop.addTarget(self, action: #selector(DropFromTop(_:)), for: .touchDown)

    buttonComeFromLeft.configuration = configurationBase
    buttonComeFromLeft.setTitle("ComeFromLeft", for: .normal)
    buttonComeFromLeft.addTarget(self, action: #selector(DropFromTop(_:)), for: .touchDown)

    buttonFadeIn.configuration = configurationBase
    buttonFadeIn.setTitle("FadeIn", for: .normal)
    buttonFadeIn.addTarget(self, action: #selector(FadeIn(_:)), for: .touchDown)

    buttonCardFlip.configuration = configurationBase
    buttonCardFlip.setTitle("CardFlip", for: .normal)
    buttonCardFlip.addTarget(self, action: #selector(CardFlip(_:)), for: .touchDown) //

    buttonTransitionFlipFromLeft.configuration = configurationBase
    buttonTransitionFlipFromLeft.setTitle("TransitionFlipFromLeft", for: .normal)
    buttonTransitionFlipFromLeft.addTarget(self, action: #selector(TransitionFlipFromLeft(_:)), for: .touchDown)

    buttonTransitionFlipFromRight.configuration = configurationBase
    buttonTransitionFlipFromRight.setTitle("Right", for: .normal)
    buttonTransitionFlipFromRight.addTarget(self, action: #selector(TransitionFlipFromRight(_:)), for: .touchDown)

    buttonTransitionFlipFromTop.configuration = configurationBase
    buttonTransitionFlipFromTop.setTitle("Top", for: .normal)
    buttonTransitionFlipFromTop.addTarget(self, action: #selector(TransitionFlipFromTop(_:)), for: .touchDown)

    buttonTransitionFlipFromBottom.configuration = configurationBase
    buttonTransitionFlipFromBottom.setTitle("Bottom", for: .normal)
    buttonTransitionFlipFromBottom.addTarget(self, action: #selector(TransitionFlipFromBottom(_:)), for: .touchDown)

    buttonTransitionCurlUp.configuration = configurationBase
    buttonTransitionCurlUp.setTitle("CurlUo", for: .normal)
    buttonTransitionCurlUp.addTarget(self, action: #selector(CurlUp(_:)), for: .touchDown)

    buttonTransitionCurlDown.configuration = configurationBase
    buttonTransitionCurlDown.setTitle("CurlDown", for: .normal)
    buttonTransitionCurlDown.addTarget(self, action: #selector(CurlDown(_:)), for: .touchDown)

    buttonTransitionCurlDownReverse.configuration = configurationBase
    buttonTransitionCurlDownReverse.setTitle("CurlDownReverse", for: .normal)
    buttonTransitionCurlDownReverse.addTarget(self, action: #selector(CurlDownReverse(_:)), for: .touchDown)

    //MARK: ResetButton
    buttonResetPopIn.configuration = configurationReset
    buttonResetPopIn.addTarget(self, action: #selector(Reset(_:)), for: .touchDown)

    buttonResetDropFromTop.configuration = configurationReset
    buttonResetDropFromTop.addTarget(self, action: #selector(ResetDFT(_:)), for: .touchDown)

    buttonResetComeFromLeft.configuration = configurationReset
    buttonResetComeFromLeft.addTarget(self, action: #selector(ResetCFL(_:)), for: .touchDown)

    buttonResetFadeIn.configuration = configurationReset
    buttonResetFadeIn.addTarget(self, action: #selector(ResetFI(_:)), for: .touchDown)

    buttonResetCardFlip.configuration = configurationReset
    buttonResetCardFlip.addTarget(self, action: #selector(ResetCF(_:)), for: .touchDown) //

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
            buttonTransitionFlipFromLeft
          }
          HStackBlock(spacing: 10, alignment: .center) {
            buttonTransitionFlipFromRight
            buttonTransitionFlipFromTop
            buttonTransitionFlipFromBottom
          }
          HStackBlock(spacing: 10, alignment: .center) {
            buttonTransitionCurlUp
            buttonTransitionCurlDown
          }
          HStackBlock(spacing: 10, alignment: .center) {
            buttonTransitionCurlDownReverse
          }
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

//MARK: PopUp
extension _UIViewTransition {
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

  @objc func FadeIn(_ sender: UIButton) {

    UIView.animate(
      withDuration: 0.5,
      delay: 1,
      options: .curveEaseIn,
      animations: {
        self.squareBlue.transform = .identity
        self.squareBlue.alpha = 1
      },
      completion: nil
    )
  }

  @objc func CardFlip(_ sender: UIButton) {

    UIView.animate(
      withDuration: 0.5,
      delay: 0.0,
      options: .curveEaseInOut,
      animations: {
        self.squareBlue.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.squareBlue.alpha = 1
      },
      completion: nil
    )
  }

  @objc func TransitionFlipFromLeft(_ sender: UIButton) {

    UIView.transition(
      with: squareBlue,
      duration: 1.0,
      options: [.transitionFlipFromLeft],
      animations: nil,
      completion: nil
    )
  }

  @objc func TransitionFlipFromRight(_ sender: UIButton) {

    UIView.transition(
      with: squareBlue,
      duration: 1.0,
      options: [.transitionFlipFromRight],
      animations: nil,
      completion: nil
    )
  }

  @objc func TransitionFlipFromTop(_ sender: UIButton) {

    UIView.transition(
      with: squareBlue,
      duration: 1.0,
      options: [.transitionFlipFromTop],
      animations: nil,
      completion: nil
    )
  }

  @objc func TransitionFlipFromBottom(_ sender: UIButton) {

    UIView.transition(
      with: squareBlue,
      duration: 1.0,
      options: [.transitionFlipFromBottom],
      animations: nil,
      completion: nil
    )
  }

  @objc func CurlUp(_ sender: UIButton) {

    UIView.transition(
      with: squareBlue,
      duration: 1.0,
      options: [.transitionCurlUp],
      animations: nil,
      completion: nil
    )
  }

  @objc func CurlDown(_ sender: UIButton) {

    UIView.transition(
      with: squareBlue,
      duration: 1.0,
      options: [.transitionCurlDown],
      animations: nil,
      completion: nil
    )
  }

  @objc func CurlDownReverse(_ sender: UIButton) {

    let squareRed = UIView(frame: self.squareBlue.frame)
    squareRed.layer.cornerRadius = 20.0
    squareRed.backgroundColor = UIColor.red

    UIView.transition(
      from: squareBlue,
      to: squareRed,
      duration: 1.0,
      options: [.transitionCurlDown, .autoreverse]
    ) { _ in
      self.view.addSubview(self.squareBlue)
      squareRed.removeFromSuperview()
    }
  }

}

//MARK: Reset
extension _UIViewTransition {

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

  @objc func ResetFI(_ sender: UIButton) {

    UIView.animate(
      withDuration: 1,
      delay: 1,
      usingSpringWithDamping: 0.47,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.offset = CGPoint(x: 0, y: 0)
        self.squareBlue.alpha = 0
      },
      completion: nil
    )
  }

  @objc func ResetCF(_ sender: UIButton) {

    UIView.animate(
      withDuration: 0.5,
      delay: 0.0,
      usingSpringWithDamping: 0.47,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.offset = CGPoint(x: 0, y: 0)
        self.squareBlue.transform = CGAffineTransform(scaleX: 1, y: 1)
        self.squareBlue.alpha = 0
      },
      completion: nil
    )
  }

}


