//
//  IfAsAnExpression.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/03.
//
//  https://x.com/v_pradeilles/status/1708808024155173299?s=20

import Foundation

fileprivate struct Sample {

  let comment: String

  init() {

    if Int.random(in: 0...3).isMultiple(of: 2) {
      comment = "It's an even integer"
    } else {
      comment = "It's an odd integer"
    }

    // if as an expression
    let _comment = if Int.random(in: 0...3).isMultiple(of: 2) {
      "It's an even integer"
    } else {
      "It's an odd integer"
    }

    print("comment: \(comment)")
    print("_comment: \(_comment)")

  }
}


