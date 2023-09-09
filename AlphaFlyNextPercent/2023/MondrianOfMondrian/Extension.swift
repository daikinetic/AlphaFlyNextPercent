//
//  Extension.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/09.
//

import UIKit

extension UIView {

  static func mock(backgroundColor: UIColor = .layeringColor) -> UIView {
    let view = UIView()
    view.backgroundColor = backgroundColor
    view.layer.borderWidth = 3
    view.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    return view
  }

  static func mock(backgroundColor: UIColor = .layeringColor, preferredSize: CGSize) -> UIView {
    let view = IntrinsicSizeView(preferredSize: preferredSize)
    view.backgroundColor = backgroundColor
    view.layer.borderWidth = 3
    view.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    return view
  }
}

final class IntrinsicSizeView: UIView {

  private let preferredSize: CGSize

  init(
    preferredSize: CGSize
  ) {
    self.preferredSize = preferredSize
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override var intrinsicContentSize: CGSize {
    preferredSize
  }

}

extension UIColor {

  static var mondrianRed: UIColor = #colorLiteral(red: 1, green: 0.5661777854, blue: 0.3006193042, alpha: 1)
  static var mondrianBlue: UIColor = #colorLiteral(red: 0.09076789767, green: 0.3224385977, blue: 0.9202803969, alpha: 1)
  static var mondrianCyan: UIColor = #colorLiteral(red: 0, green: 0.856479466, blue: 1, alpha: 1)
  static var mondrianYellow: UIColor = #colorLiteral(red: 1, green: 0.4053340554, blue: 0, alpha: 1)
  static var mondrianGray: UIColor = #colorLiteral(red: 0.6430723071, green: 0.6431827545, blue: 0.6430577636, alpha: 1)
  static var layeringColor: UIColor {
    return .init(white: 0, alpha: 0.2)
  }
}

