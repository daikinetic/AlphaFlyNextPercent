//
//  TagLayout.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/18.
//

import SwiftUI

struct TagLayout: Layout {
  // Layout Propertie
  var alignment: Alignment = .center
  // Both Horizontal & Vertical
  var spacing: CGFloat = 10

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {

    let maxWidth = proposal.width ?? 0
    var height: CGFloat = 0
    let rows = generateRows(maxWidth, proposal, subviews)

    for (index, row) in rows.enumerated() {
      // Finding max Height in each row and adding it to the View's Total Height
      if index == (rows.count - 1) {
        // Since there is no spacing needed for the last item
        height += row.maxHeight(proposal)
      } else {
        height += row.maxHeight(proposal) + spacing
      }
    }

    return .init(width: maxWidth, height: height)
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {

    // Placing Views
    var origin = bounds.origin
    let maxWidth = bounds.width
    let rows = generateRows(maxWidth, proposal, subviews)

    for row in rows {
      

      // Resetting Origin X to Zero for Each Row
      origin.x = 0

      for view in row {
        let viewSize = view.sizeThatFits(proposal)
        view.place(at: origin, proposal: proposal)
        // Updating Origin X
        origin.x += (viewSize.width + spacing)
      }

      // Updating Origin Y
      origin.x += (row.maxHeight(proposal) + spacing)
    }

  }

  // Generating Rows based on Available Size
  func generateRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {

    var row: [LayoutSubviews.Element] = []
    var rows: [[LayoutSubviews.Element]] = []

    var origin = CGRect.zero.origin

    for view in subviews {
      let viewSize = view.sizeThatFits(proposal)

      // Pushing to New Row
      if (origin.x + viewSize.width + spacing) > maxWidth {
        rows.append(row)
        row.removeAll()
        // Resetting X Origin since it needs to start from left to right
        origin.x = 0
        row.append(view)
        // Updating Origin X
        origin.x += (viewSize.width + spacing)
      } else {
        // Adding item to Same Row
        row.append(view)
        // Updating OriginX
        origin.x += (viewSize.width + spacing)
      }
    }

    // Checking for any exhaust row
    if !row.isEmpty {
      rows.append(row)
      row.removeAll()
    }

    return rows
  }

}

// Returns Maximum Height From the Row
extension [LayoutSubviews.Element] {
  func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
    return self.compactMap { view in
      return view.sizeThatFits(proposal).height
    }.max() ?? 0
  }
}

struct TagLayout_Previews: PreviewProvider {
  static var previews: some View {
    TagTextFieldContentView()
  }
}
