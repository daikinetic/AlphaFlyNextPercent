//
//  keyPathExpression.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/17.
//
//  https://x.com/sarunw/status/1702787193402450382?s=20

import Foundation

private struct User {
  let name: String

  init(name: String) {
    self.name = name
  }
}

private let users = [
  User(name: "John"),
  User(name: "Johns"),
  User(name: "Johnst"),
  User(name: "Johnste"),
  User(name: "Johnster")
]

// Swift key path expression \Root.value can use wherever functions of (Root) -> Value are allowed.
// let userNames = users.map(<#T##(Self.Element) -> T#>)

let userNames = users.map { user in
  return user.name
}

// KeyPath version
let userNamesKeyPathVer = users.map(\.name)

