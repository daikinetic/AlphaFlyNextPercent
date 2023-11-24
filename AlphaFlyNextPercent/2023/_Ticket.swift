//
//  _Ticket.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/24.
//

import Foundation
import UIKit
import MondrianLayout

final class _Ticket: UIViewController {

  let container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 300.0))
  let squareBlue = TicketItem(size: CGRect(x: 0.0, y: 0.0, width: 350.0, height: 200.0))
  let safeAreaInsetsVertical: CGFloat = 59 + 34
  let paddingVertical: CGFloat = 20

  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white

    container.backgroundColor = .mondrianBlue

    squareBlue.layer.cornerRadius = 20.0
    squareBlue.backgroundColor = UIColor.layeringColor
    squareBlue.alpha = 1

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let squareBluePaddingVertical = ((
      view.bounds.height - safeAreaInsetsVertical - (paddingVertical * 2) - squareBlue.frame.height
    )) / 2

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        VStackBlock(alignment: .center) {

          squareBlue
            .viewBlock
            .size(
              width: LayoutDescriptor.ConstraintValue(floatLiteral: squareBlue.frame.width),
              height: LayoutDescriptor.ConstraintValue(floatLiteral: squareBlue.frame.height)
            )
            .padding(.vertical, squareBluePaddingVertical)

        }
        .padding(.all, paddingVertical)
      }
      .container(respectingSafeAreaEdges: .all)

    }
  }
}

final class TicketItem: UIView {
  let size: CGRect
  let text: UILabel = .init()

  init(size: CGRect) {
    self.size = size
    super.init(frame: size)

    text.text = "April Mol-74"
    text.font = .scaledFont(style: .title1, weight: .bold)

    Mondrian.buildSubviews(on: self) {
      VStackBlock {
        text
      }
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
