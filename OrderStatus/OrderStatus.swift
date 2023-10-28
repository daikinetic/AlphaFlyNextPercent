//
//  OrderStatus.swift
//  OrderStatus
//
//  Created by Daiki Takano on 2023/10/28.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct OrderStatus: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: OrderAttributes.self) { context in
      // MARK: live activity view

      ZStack {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
          .fill(Color(.green).gradient)
      }

    } dynamicIsland: { _ in return }
  }
}

