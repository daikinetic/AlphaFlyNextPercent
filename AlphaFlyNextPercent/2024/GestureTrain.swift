//
//  GestureTrain.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/02/19.
//
//  https://qiita.com/Hyperbolic_____/items/678693529e690efe9e9e

import UIKit
import MondrianLayout
import FBSDKShareKit

final class GestureTrainVC: UIViewController {

  private let sampleView = SampleGestureView(frame: .init(x: 0, y: 0, width: 150, height: 150))
  private let titleView = UITextView(frame: .init(x: 0, y: 0, width: 400, height: 200))

  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(sampleView)
    view.addSubview(titleView)
    titleView.text = "Mastering \nUIGestureRecognizer"
    titleView.font = .boldSystemFont(ofSize: 30)
    titleView.textContainer.maximumNumberOfLines = 2
    titleView.textContainer.lineBreakMode = .byWordWrapping
    titleView.textAlignment = .left
    titleView.textContainer.lineFragmentPadding = 20
    titleView.textColor = .black

    sampleView.mondrian.layout
      .center(.toSuperview)
      .size(width: 150, height: 150)
      .activate()

    titleView.mondrian.layout
      .top(.to(view.safeAreaLayoutGuide).top)
      .left(.to(view.safeAreaLayoutGuide).left, .exact(16))
      .size(width: 400, height: 80)
      .activate()
  }
}

private final class SampleGestureView: UIView {
  var ownTransform: CGAffineTransform = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemPink
    addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panObject(_:))))
    addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchObject(_:))))
    addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(rotateObject(_:))))
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapObject(_:))))
    addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressObject(_:))))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func panObject(_ sender: UIPanGestureRecognizer) {
    if sender.state == .began {
      ownTransform = self.transform
    }
    self.transform = ownTransform.translatedBy(x: sender.translation(in: self).x, y: sender.translation(in: self).y)
  }

  @objc func tapObject(_ sender: UITapGestureRecognizer) {
    self.backgroundColor = UIColor.randomColor
  }

  @objc func rotateObject(_ sender: UIRotationGestureRecognizer) {
    let rotation = sender.rotation
    if sender.state == .began {
      ownTransform = self.transform
    }
    self.transform = ownTransform.rotated(by: rotation)
  }

  @objc func pinchObject(_ sender: UIPinchGestureRecognizer) {
    if sender.state == .began {
      ownTransform = self.transform
    }
    self.transform = ownTransform.scaledBy(x: sender.scale, y: sender.scale)
  }

  @objc func longPressObject(_ sender: UILongPressGestureRecognizer) {
    UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
      self.transform = CGAffineTransform(scaleX: 2, y: 2)
    })
  }

}

extension UIColor {
  static var randomColor: UIColor {
    let r = CGFloat.random(in: 0 ... 255) / 255.0
    let g = CGFloat.random(in: 0 ... 255) / 255.0
    let b = CGFloat.random(in: 0 ... 255) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
  }
}
