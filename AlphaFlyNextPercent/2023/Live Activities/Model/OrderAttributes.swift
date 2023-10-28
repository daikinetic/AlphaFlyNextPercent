//
//  OrderAttributes.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/28.
//

import SwiftUI
import ActivityKit

struct OrderAttributes: ActivityAttributes {
  struct ContentState: Codable, Hashable {
    // MARK: live activities will update its view when content state is updated
    var status: Status = .received
  }

  // MARK: other propeties
  var orderNumber: Int
  var orderItems: String
}

// MARK: Order Status
enum Status: String, CaseIterable, Codable, Equatable {
  case received = "shippingbox.fill"
  case progress = "person.bust"
  case ready = "takeoutbag.and.cup.and.straw.fill"
}
