//
//  SectorChartExample.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/29.
//
//  https://x.com/mecid/status/1707347930623914260?s=20

import SwiftUI
import Charts

struct SectorChartExample: View {
  @State private var products: [Product] = [
    .init(title: "Annual", revenue: 0.7),
    .init(title: "Monthly", revenue: 0.2),
    .init(title: "Lifetime", revenue: 0.1)
  ]

  var body: some View {
    Chart(products) { product in
      SectorMark(
        angle: .value(
          Text(verbatim: product.title),
          product.revenue
        )
      )
      .foregroundStyle(
        by: .value(
          Text(verbatim: product.title),
          product.title
        )
      )
    }
  }
}

#Preview {
  SectorChartExample()
}

fileprivate struct Product: Identifiable {
  let id = UUID()
  let title: String
  let revenue: Double
}
