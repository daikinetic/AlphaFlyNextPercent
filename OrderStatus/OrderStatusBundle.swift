//
//  OrderStatusBundle.swift
//  OrderStatus
//
//  Created by Daiki Takano on 2023/10/28.
//

import WidgetKit
import SwiftUI

@main
struct OrderStatusBundle: WidgetBundle {
    var body: some Widget {
        OrderStatus()
        OrderStatusLiveActivity()
    }
}
