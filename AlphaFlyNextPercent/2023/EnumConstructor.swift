//
//  EnumConstructor.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/01.
//
//  https://qiita.com/_mpon/items/4491d19fa50b2039af35

import Foundation

fileprivate enum Size {
  case Small
  case Medium
  case Large
}

fileprivate enum _Size {
  case Small
  case Medium
  case Large
  
  init() {
    self = .Small
  }
}


enum Size_ {
  case Small, Medium, Large

  // 引数ありコンストラクタ
  init(height: Int) {
    if height < 160 {
      self = .Small
    } else if height < 170 {
      self = .Medium
    } else {
      self = .Large
    }
  }
}

enum _Size_ {
  case Small, Medium, Large

  // 失敗するかもしれないコンストラクタ
  init?(height: Int) {
    if height < 160 {
      self = .Small
    } else if height < 170 {
      self = .Medium
    } else if height < 180 {
      self = .Large
    } else {
      return nil
    }
  }
}

