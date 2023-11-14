//
//  IFCase.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/14.
//
//  https://qiita.com/Toshi_Tab/items/17d2087119d196d44bb2

import Foundation

private final class IFCase_1: ViewController{

  override func viewDidLoad() {

    //MARK: この条件のとき、これをしたいと言うときにswitchは重装

    let value = 1

    if case 0 ..< 10 = value {
      print("match")
    }

    switch value {
    case 0 ..< 10:
      print("match")
    default:
      print("not match")
    }
  }

}

private final class IFCase_2: ViewController{

  enum Drink {
    case Coffee
    case Water
  }

  override func viewDidLoad() {

    //MARK: この条件のとき、これをしたいと言うときにswitchは重装

    let drink = Drink.Coffee

    if case .Coffee = drink {
      print("coffee")
    }

    switch drink {
    case .Coffee:
      print("coffee")
    case .Water:
      print("water")
    }
  }
}


//MARK: ~=
private final class IFCase_4: ViewController{

  enum Drink {
    case Coffee
    case Water
  }

  override func viewDidLoad() {

    let drink = Drink.Coffee

    if .Coffee ~= drink {
      print("coffee")
    }

    let value = 1

    if 0 ..< 10 ~= value {
      print("match")
    }

  }
}

//MARK: guard case

private final class IFCase_3: ViewController{

  enum APIResponseType {
    case Success(data: String, statusCode: Int)
    case Error(data: String, statusCode: Int)
  }

  override func viewDidLoad() {

    let result = APIResponseType.Success(data: "Success", statusCode: 200)

    if case .Success(let data, let statusCode) = result {
      print("statusCode: \(statusCode)")
      print("data \(data)")
    }
  }
}

private final class IFCase_3_1: ViewController{

  enum APIResponseType {
    case Success(data: String, statusCode: Int)
    case Error(data: String, statusCode: Int)
  }

  let result = APIResponseType.Success(data: "Success", statusCode: 200)

  func test() {
    guard case .Success(let data, let statusCode) = result else {
      return
    }
    print("statusCode: \(statusCode)")
    print("data \(data)")

  }
}



