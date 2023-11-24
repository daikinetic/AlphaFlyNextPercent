//
//  _ConvenienceInitializer.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/03.
//
//  https://qiita.com/edo_m18/items/733d8c81fb00942e3167

import Foundation

fileprivate class SomeClass {
  var name: String
  init(name: String) {
    self.name = name
  }

  convenience init() {
    self.init(name: "default name") // can use desinated initializer
  }
}

final fileprivate class SubClass: SomeClass {
  var hoge: String
  init() {
    self.hoge = "foo" // variable defined at Subclass
    super.init(name: "hogehoge") // desinated initializer of SuperClass
    self.name = "name" // variable difined at SuperClass
  }
}
