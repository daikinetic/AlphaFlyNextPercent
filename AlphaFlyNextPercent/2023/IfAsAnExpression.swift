//
//  IfAsAnExpression.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/03.
//
//  https://x.com/v_pradeilles/status/1708808024155173299?s=20

import Foundation

fileprivate struct Sample {

  init() {

    let comment: String

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


    // also works with a `switch`
    let spelledOut: String

    switch Int.random(in: 0...3) {
    case 0:
      spelledOut = "Zero"
    case 1:
      spelledOut = "One"
    case 2:
      spelledOut = "Two"
    case 3:
      spelledOut = "Three"
    default:
      spelledOut = "Out of range"
    }

    // This could be rewritten as follows
    let _spelledOut = switch Int.random(in: 0...3) {
    case 0:
      "Zero"
    case 1:
      "One"
    case 2:
      "Two"
    case 3:
      "Three"
    default:
      "Out of range"
    }

  }
}


