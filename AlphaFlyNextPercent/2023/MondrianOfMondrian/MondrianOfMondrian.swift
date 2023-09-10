//`
//  MondrianOfMondrian.swift
//  AlphaFlyNext%
//
//  Created by Daiki Takano on 2023/09/09.
//

import UIKit
import MondrianLayout

final class MondrianOfMondrian: UIViewController {

  //MARK: - Properties

  //MARK: - Initializer
  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white


  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Functions
  override func viewDidLoad() {

    Mondrian.buildSubviews(on: view) {
      VStackBlock {
        HStackBlock(spacing: 2, alignment: .fill) {

          //MARK: Line 1
          VStackBlock(spacing: 2, alignment: .fill) {
            UIView.mock(backgroundColor: .mondrianRed, preferredSize: .init(width: 28, height: 28))
            UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 56))
            UIView.mock(backgroundColor: .mondrianYellow, preferredSize: .init(width: 28, height: 28))
            UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
            HStackBlock(spacing: 2, alignment: .fill) {
              UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))

              UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
            }
          }

          //MARK: Line 2
          VStackBlock(spacing: 2, alignment: .fill) {
            HStackBlock(spacing: 2, alignment: .fill) {
              UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))

              VStackBlock(spacing: 2, alignment: .fill) {
                HStackBlock(spacing: 2, alignment: .fill) {
                  UIView.mock(backgroundColor: .mondrianYellow, preferredSize: .init(width: 28, height: 28))
                  UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
                }

                UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
              }
            }

            HStackBlock(spacing: 2, alignment: .fill) {

              VStackBlock(spacing: 2, alignment: .fill) {
                UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
                UIView.mock(backgroundColor: .mondrianBlue, preferredSize: .init(width: 28, height: 28))
              }

              UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))

              VStackBlock(spacing: 2, alignment: .fill) {
                UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
                UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
              }
            }

            HStackBlock(spacing: 2, alignment: .fill) {
              UIView.mock(backgroundColor: .mondrianRed, preferredSize: .init(width: 28, height: 28))

              VStackBlock(spacing: 2, alignment: .fill) {
                UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
                UIView.mock(backgroundColor: .layeringColor, preferredSize: .init(width: 28, height: 28))
              }
            }
          }
        }
        .size(width: 225, height: 225)
        .padding(.top, 250)
        .overlay(
          UILabel.mockMultiline(text: "Mondrian Layout", textColor: .white)
            .viewBlock
            .padding(4)
            .background(
              UIView.mock(backgroundColor: .layeringColor)
                .viewBlock
            )
            .relative(.bottom, 8)
            .relative(.trailing, 8)
        )

      }
      .container(
        top: .safeArea(.top),
        leading: .view(.leading),
        bottom: .safeArea(.bottom),
        trailing: .view(.trailing)
      )

    }


  }

}
