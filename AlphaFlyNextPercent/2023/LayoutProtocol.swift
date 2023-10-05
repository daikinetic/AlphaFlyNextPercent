//
//  LayoutProtocol.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/04.
//
//  https://x.com/mecid/status/1709164650695192996?s=20

// the Layout protocol allowing us to build super-custom layouts
// by digging into the layout system without using GeometryReader.
// Layout protocol brings us the incredible power
// of building and reusing any layout you can imagine.

import Foundation
import SwiftUI

struct FlowLayout: Layout {
  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    //
  }
  
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }

    var totalHeight: CGFloat = 0
    var totalWidth: CGFloat = 0

    var lineHeight: CGFloat = 0
    var lineWidth: CGFloat = 0

    for size in sizes {
      if lineWidth + size.width > proposal.width ?? 0 {
        totalHeight += lineHeight
        lineWidth = size.width
        lineHeight = size.height
      } else {
        lineWidth += size.width
        lineHeight = max(lineHeight, size.height)
      }

      totalWidth = max(totalWidth, lineWidth)
    }

    totalHeight += lineHeight

    return .init(width: totalWidth, height: totalHeight)
  }
}
