//
//  tapGestureController.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/30.
//
//  https://qiita.com/sasao3/items/9f1b4a0b42f221923c5a

import UIKit

//UIGestureRecognizerDelegateを追加する
final class TapViewController: UIViewController, UIGestureRecognizerDelegate {

  let newColors = [
    UIColor.purple.cgColor,
    UIColor.red.cgColor,
    UIColor.orange.cgColor
  ]

  let newColors2 = [
    UIColor.purple.cgColor,
    UIColor.blue.cgColor,
    UIColor.green.cgColor
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

    //シングルタップ用のインスタンスを生成する
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(TapViewController.singleTap(_:))
    )

    //デリゲートをセット
    tapGesture.delegate = self

    //viewにタップジェスチャーを追加
    self.view.addGestureRecognizer(tapGesture)

    //ロングプレス用のインスタンスを生成する
    let longPressGesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(TapViewController.longPress(_:))
    )

    //デリゲートをセット
    longPressGesture.delegate = self

    //viewにロングプレスジェスチャーを追加
    self.view.addGestureRecognizer(longPressGesture)

  }

  //シングルタップ時に実行されるメソッド
  @objc func singleTap(_ sender: UITapGestureRecognizer) {
    if sender.state == .ended {
      //ここに、タップ終了時に実行したい処理を記載する
      linearGradient.setColors(
        newColors,
        animated: true,
        withDuration: 2,
        timingFunctionName: .easeInEaseOut
      )
    }
  }

  //ロングプレス時に実行されるメソッド
  @objc func longPress(_ sender: UILongPressGestureRecognizer) {

    if sender.state == .ended {
      //ロングプレス終了時に実行したい処理を記載する
      linearGradient.setColors(
        newColors2,
        animated: true,
        withDuration: 2,
        timingFunctionName: .easeInEaseOut
      )
    }
  }
}

final class _AnimatedGradientController: UIViewController {

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
