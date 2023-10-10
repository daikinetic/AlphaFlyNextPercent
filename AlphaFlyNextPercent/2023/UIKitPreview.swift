//
//  UIKitPreview.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/10.
//
//  https://x.com/_take_hito_/status/1710290960360391026?s=20

import UIKit
import MondrianLayout

class ViewController: UIViewController {
  let label: UILabel
  let imageView: UIImageView

  init(label: UILabel, imageView: UIImageView) {
    self.label = label
    self.imageView = imageView

    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    Mondrian.buildSubviews(on: view) {
      VStackBlock {
        imageView
          .viewBlock.spacingAfter(10)

        label
      }
    }
  }
}

#Preview {

  let font: UIFont = .scaledFont(style: .largeTitle, weight: .bold)
  let label: UILabel = .init()
  label.text = "さよなら歌姫"
  label.font = font

  let controller: ViewController = .init(
    label: label,
    imageView: .init()
  )

  controller.imageView.image = .init(systemName: "globe", font: font)

  return controller
}

extension UIFont {
  static func scaledFont(style: TextStyle, weight: Weight) -> UIFont {
    UIFontMetrics(forTextStyle: style).scaledFont(
      for: .systemFont(
        ofSize: UIFont.preferredFont(forTextStyle: style).pointSize,
        weight: weight
      )
    )
  }
}

extension UIImage {
  convenience init?(systemName: String, font: UIFont) {
    self.init(
      systemName: systemName,
      withConfiguration: UIImage.SymbolConfiguration(font: font)
    )
  }
}
