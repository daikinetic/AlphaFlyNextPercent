//
//  TypealiasPatterns.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/31.
//
//  https://betterprogramming.pub/5-ways-to-use-type-alias-in-swift-45ddce3cc941

import Foundation

protocol CafeteriaAccess {
  //
}

protocol LabAccess {
  //
}

struct TypealiasPatterns_1 {

  //MARK: Typealias Combining Protocols

  private typealias Codable = Decodable & Encodable
  private typealias BuildingAccess = CafeteriaAccess & LabAccess

  //MARK: Type Alias Semantics Primitive Types
  func heatProduced() -> Double {
    return 0
  }

  private typealias Jules = Double
  private func _heatProduced() -> Jules {
    return 0
  }

  //MARK: Type Alias Generics
  private typealias EventList<T> = Array<T>
  private let array: EventList = EventList(arrayLiteral: 1, 2, 3)

  private typealias _EventList<T> = Array<T> where T: StringProtocol

  //MARK: Type Alias Closure
  private func upload(
    success: ((Int) -> Int)?,
    failure: ((Error) -> Void)?,
    progress: ((Double) -> Void)?
  ) {
    //
  }

  private typealias Success = (Int) -> Int
  private typealias Failure = (Error) -> Void
  private typealias Progress = (Double) -> Void
  private func _upload(
    success: Success?,
    failure: Failure?,
    progress: Progress?
  ) {
    //
  }

}

//MARK: Type Alias Associated Type Protocols
private protocol Example {
  associatedtype load: StringProtocol
}

struct Implement: Example {
  fileprivate typealias load = String
}



