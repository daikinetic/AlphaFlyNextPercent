//
//  _Protocol_Train.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/24.
//
//  https://qiita.com/abouch/items/67f9def6dc2feec3e183

import Foundation
import UIKit

//
protocol SomeProtocol {
  var computedA: String { get }
  func methodA(_ str: String)
  func methodB(a: Int, b: Int) -> Int
}

final class SomeClass {}

extension SomeClass: SomeProtocol {
  var computedA: String {
    return "A"
  }
  
  func methodA(_ str: String) {
    print(str)
  }
  
  func methodB(a: Int, b: Int) -> Int {
    return a + b
  }
}

//
protocol _SomeProtocol {}

extension _SomeProtocol {
  func className() {
    print(String(describing: type(of: self)))
  }
}

//
protocol _SomeProtocol_ {}

extension _SomeProtocol_ {
  var someString: String {
    return "some"
  }
}

class someClass: _SomeProtocol_ {
  var someString: String {
    return "conforming type implementation"
  }
}

//
protocol SomeProtocolEx {}

extension SomeProtocolEx {
  func sayHello() {
    print("hello")
  }
}

extension SomeProtocolEx where Self: SomeClass {
  func someMethod() {
    print("instance of SomeClass can use this method")
  }
}

//
protocol MyView: UIView {}
protocol _MyView where Self: UIView {}

//
protocol MyView_ {}
extension MyView_ where Self: UIView {}

//
protocol _MyView_: UIView {}
extension _MyView_ {
  func setWhiteBackgroundColor() {
    backgroundColor = UIColor.white
  }
}

//
protocol _Reusable {
  static var reuseIdentifier: String { get }
}

extension _Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: _Reusable {}

extension UITableView {
  func register<T: UITableViewCell>(_ cell: T.Type) {
    register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? T else {
      fatalError("missing")
    }
    return cell
  }
}

//
protocol Extensible {
  associatedtype ExtensibleType
  static var ex: Extension<ExtensibleType>.Type { get }
  var ex: Extension<ExtensibleType> { get }
}

extension Extensible {
  public static var ex: Extension<Self>.Type {
    return Extension<Self>.self
  }
  public var ex: Extension<Self> {
    return Extension(self)
  }
}

public struct Extension<Base> {
  public let base: Base
  public init(_ base: Base) {
    self.base = base
  }
}

extension NSObject: Extensible {}

extension Extension where Base: UIImageView {
  func load(from urlString: String) {
    // load image from urlString
  }
}

//
struct Item {}

protocol DataStoreProtocol {
  func getItem() -> Item
}

final class _ViewModel {
  private var dataStore: DataStoreProtocol

  init(dataStore: DataStoreProtocol) {
    self.dataStore = dataStore
  }

  func getItem() -> Item {
    return dataStore.getItem()
  }
}

struct DataStoreStub: DataStoreProtocol {
  func getItem() -> Item {
    return Item()
  }
}
