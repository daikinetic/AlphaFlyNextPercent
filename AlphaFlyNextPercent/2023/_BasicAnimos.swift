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
  let square = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
  let buttonPopIn = UIButton(type: .system)
  let buttonReset = UIButton(type: .system)

  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white
    view.addSubview(square)

    square.layer.cornerRadius = 20.0
    square.backgroundColor = UIColor.blue
    square.alpha = 0
    square.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

    var configuration = UIButton.Configuration.gray()

    buttonPopIn.configuration = configuration
    buttonPopIn.setTitle("PopIn", for: .normal)
    buttonPopIn.tintColor = .blue
    buttonPopIn.addTarget(self, action: #selector(PopIn(_:)), for: .touchDown)

    buttonReset.configuration = configuration
    buttonReset.setTitle("Reset", for: .normal)
    buttonReset.tintColor = .red
    buttonReset.addTarget(self, action: #selector(Reset(_:)), for: .touchDown)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        square
          .viewBlock.padding(50)
        HStackBlock(spacing: 10, alignment: .center) {
          buttonPopIn
          buttonReset
        }

      }
      .size(
        width: LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width),
        height: LayoutDescriptor.ConstraintValue(floatLiteral: view.bounds.width)
      )
      .padding(.vertical, 200)

    }
  }
}

extension BasicAnimos {
  @objc func PopIn(_ sender: UIButton) {

    UIView.animate(
      withDuration: 0.5,
      delay: 1,
      usingSpringWithDamping: 0.55,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.square.transform = .identity
        self.square.alpha = 1
      },
      completion: nil
    )
  }

  @objc func Reset(_ sender: UIButton) {

    UIView.animate(
      withDuration: 0.5,
      delay: 1,
      usingSpringWithDamping: 0.55,
      initialSpringVelocity: 3,
      options: .curveEaseOut,
      animations: {
        self.square.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.square.alpha = 0
      },
      completion: nil
    )

  }
}
