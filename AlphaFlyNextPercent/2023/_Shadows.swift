//
//  _Shadows.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/27.
//
//  https://medium.com/swlh/how-to-create-advanced-shadows-in-swift-ios-swift-guide-9d2844b653f8

import Foundation
import UIKit
import MondrianLayout

final class ShadowDropController: UIViewController {

  let imageView: UIImageView = .init()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    imageView.frame = .init(origin: .zero, size: .init(width: 200, height: 200))

    imageView.image = .init(named: "mountain")
    imageView.layer.shadowRadius = 10
    imageView.layer.shadowOffset = .zero
    imageView.layer.shadowOpacity = 0.5
    imageView.layer.shadowColor = UIColor.black.cgColor
    imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        imageView
          
      }
      .height(200)
      .width(300)
      .padding(.vertical, 300)
      .padding(.leading, 50)
    }
  }

}

final class ShadowContactController: UIViewController {

  let imageView: UIImageView = .init()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    imageView.frame = .init(origin: .zero, size: .init(width: 200, height: 200))

    imageView.image = .init(named: "mountain")
    let size: CGFloat = 20
    let distance: CGFloat = 0
    let rect = CGRect(
        x: -size,
        y: imageView.frame.height - (size * 0.4) + distance,
        width: imageView.frame.width + size * 2,
        height: size
    )

    imageView.layer.shadowColor = UIColor.black.cgColor
    imageView.layer.shadowRadius = 7
    imageView.layer.shadowOpacity = 0.7
    imageView.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        imageView

      }
      .height(200)
      .width(300)
      .padding(.vertical, 300)
      .padding(.leading, 50)
    }
  }

}


final class ShadowContactWithDepthController: UIViewController {

  let imageView: UIImageView = .init()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    imageView.frame = .init(origin: .zero, size: .init(width: 200, height: 200))

    imageView.image = .init(named: "mountain")

    let scale = CGSize(width: 1.25, height: 0.5)
    let offsetX: CGFloat = 0

    let shadowPath = UIBezierPath()
    shadowPath.move(to:
        CGPoint(
            x: 0,
            y: imageView.frame.height
        )
    )
    shadowPath.addLine(to:
        CGPoint(
            x: imageView.frame.width,
            y: imageView.frame.height
        )
    )
    shadowPath.addLine(to:
        CGPoint(
            x: imageView.frame.width * scale.width + offsetX,
            y: imageView.frame.height * (1 + scale.height)
        )
    )
    shadowPath.addLine(to:
        CGPoint(
            x: imageView.frame.width * (1 - scale.width) + offsetX,
            y: imageView.frame.height * (1 + scale.height)
        )
    )

    imageView.layer.shadowColor = UIColor.black.cgColor
    imageView.layer.shadowRadius = 7
    imageView.layer.shadowOpacity = 0.7
    imageView.layer.shadowPath = shadowPath.cgPath


    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        imageView

      }
      .height(200)
      .width(300)
      .padding(.vertical, 300)
      .padding(.leading, 50)
    }
  }

}

final class ShadowContactFlatController: UIViewController {

  let imageView: UIImageView = .init()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    imageView.frame = .init(origin: .zero, size: .init(width: 200, height: 200))

    imageView.image = .init(named: "mountain")

    let scale = CGSize(width: 1.5, height: 1.5)
    let offset = CGPoint(x: imageView.frame.width, y: -imageView.frame.height)

    let shadowPath = UIBezierPath()
    shadowPath.move(to:
        CGPoint(
            x: 0,
            y: imageView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == 1 ? 0 : offset.y)
        )
    )
    shadowPath.addLine(to:
        CGPoint(
            x: imageView.frame.width,
            y: imageView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == -1 ? 0 : offset.y)
        )
    )
    shadowPath.addLine(to:
        CGPoint(
            x: imageView.frame.width * scale.width + offset.x,
            y: imageView.frame.height * (1 + scale.height) + offset.y
        )
    )
    shadowPath.addLine(to:
        CGPoint(
            x: imageView.frame.width * (1 - scale.width) + offset.x,
            y: imageView.frame.height * (1 + scale.height) + offset.y
        )
    )
    imageView.layer.shadowPath = shadowPath.cgPath
    imageView.layer.shadowRadius = 0
    imageView.layer.shadowOffset = .zero
    imageView.layer.shadowOpacity = 0.2
    imageView.layer.shadowColor = UIColor.black.cgColor
    
    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        imageView

      }
      .height(200)
      .width(300)
      .padding(.vertical, 300)
      .padding(.leading, 50)
    }
  }

}



