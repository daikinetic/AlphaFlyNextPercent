//
//  AnimateFlip.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/08.
//

import Foundation
import UIKit

extension UIView {
  public enum FlipDirection {
    case left
    case right
  }

  public func animateFlip(
    direction: FlipDirection,
    completion: @escaping () -> Void = {}
  ) {

    let angle: Double
    switch direction {
    case .left:
      angle = 13
    case .right:
      angle = -13
    }

    UIImpactFeedbackGenerator(style: .light).impactOccurred()

    UIView.animateKeyframes(
      withDuration: 0.16,
      delay: 0,
      options: [.allowUserInteraction],
      animations: {

        UIView.addKeyframe(
          withRelativeStartTime: 0,
          relativeDuration: 1 / 2,
          animations: {
            var transform = CATransform3DIdentity
            transform.m34 = 1 / 1000
            transform = CATransform3DRotate(transform, CGFloat(Double.pi * angle / 180), 0, 1, 0)
            self.layer.transform = transform
          }
        )

        UIView.addKeyframe(
          withRelativeStartTime: 1 / 2,
          relativeDuration: 1 / 2,
          animations: {
            var transform = CATransform3DIdentity
            transform.m34 = 1 / 1000
            transform = CATransform3DRotate(transform, CGFloat(Double.pi * angle / 180), 0, 1, 0)
            self.layer.transform = transform
          }
        )
      }, completion: { _ in

        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        completion()

        UIView.animate(
          withDuration: 0.1,
          delay: 0.0,
          options: [
            .curveEaseIn,
            .allowUserInteraction,
            .beginFromCurrentState
          ],
          animations: {
            //self.contentOffset = 0
          },
          completion: nil
        )
      }
    )

  }
}

import UIKit

//UIGestureRecognizerDelegateを追加する
final class OnTapViewController: UIViewController, UIGestureRecognizerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    //シングルタップ用のインスタンスを生成する
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(TapViewController.singleTap(_:))
    )

    //デリゲートをセット
    tapGesture.delegate = self

    //viewにタップジェスチャーを追加
    self.view.addGestureRecognizer(tapGesture)

  }

  //シングルタップ時に実行されるメソッド
  @objc func singleTap(_ sender: UITapGestureRecognizer) {
    if sender.state == .ended {
      //ここに、タップ終了時に実行したい処理を記載する
      view.animateFlip(direction: .left)
      

    }
  }

  //ロングプレス時に実行されるメソッド
  @objc func longPress(_ sender: UILongPressGestureRecognizer) {

    if sender.state == .ended {
      //ロングプレス終了時に実行したい処理を記載する

    }
  }
}
