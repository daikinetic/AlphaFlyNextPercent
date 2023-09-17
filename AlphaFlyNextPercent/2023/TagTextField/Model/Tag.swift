//
//  Tag.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/18.
//

import SwiftUI

struct Tag: Identifiable, Hashable {
  var id: UUID = .init()
  var value: String
  var isInitial: Bool = false
  var isFocused: Bool = false
}
