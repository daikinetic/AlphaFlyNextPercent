//
//  _Protocol_Train.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/24.
//
//  https://qiita.com/abouch/items/67f9def6dc2feec3e183

import Foundation
import UIKit
import SwiftUI

#Preview {
  SomeView()
}

//
protocol SomeProtocol {
  var computedA: String { get }
  func methodA(_ str: String)
  func methodB(a: Int, b: Int) -> Int
}

fileprivate final class SomeClass {}

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

//MARK: https://medium.com/swift2go/mastering-generics-with-protocols-the-specification-pattern-5e2e303af4ca

fileprivate enum Size {
  case small, medium, large
}

fileprivate enum Color {
  case red, green, blue
}

fileprivate struct Product {
  var name: String
  var color: Color
  var size: Size
}

extension Product: CustomStringConvertible {
  var description: String {
    return "\(size) \(color) \(name)"
  }
}

//
fileprivate struct ProductFilter {
  static func filterProducts(_ products: [Product], by size: Size) -> [Product] {

    var output = [Product]()
    for product in products where product.size == size {
      output.append(product)
    }
    return output
  }
}

// MARK: - Technique 1: Setting associatedtypes with typealias
// MARK: - associatedtype T, then set, typealias T = SomeType.
fileprivate protocol Specification {
  associatedtype T
  func isSatisfied(item: T) -> Bool
}

fileprivate struct ColorSpecification: Specification {
  typealias T = Product
  var color: Color

  func isSatisfied(item: Product) -> Bool {
    return item.color == color
  }
}

fileprivate struct SizeSpecification: Specification {
  typealias T = Product
  var size: Size

  func isSatisfied(item: Product) -> Bool {
    return item.size == size
  }
}

// MARK: - Technique 2: Checking conditions on generic instances
// MARK: - func someFunc<T: SomeType>(argument: T) where T.someProperty == self.someProperty
fileprivate protocol Filter {
  associatedtype T
  func filter<Spec: Specification>(items: [T], specs: Spec) -> [T] where Spec.T == T
}

fileprivate struct _ProductFilter {
  typealias T = Product
  func filter<Spec: Specification>(items: [Product], specs: Spec) -> [Product] where _ProductFilter.T == Spec.T {
    var output = [T]()
    for item in items {
      if specs.isSatisfied(item: item) {
        output.append(item)
      }
    }
    return output
  }
}


// MARK: - Technique 3: Setting associatedtypes with static initialization
// MARK: - struct MyStruct<T> : ProtocolType {} / let a = MyStruct<SomeType>()
fileprivate protocol Sized {
  var size: Size { get set }
}

fileprivate protocol Colored {
  var color: Color { get set }
}

extension Product: Colored, Sized {}

fileprivate struct _ColorSpecification<T: Colored> : Specification {
  var color: Color
  func isSatisfied(item: T) -> Bool {
    return item.color == color
  }
}

fileprivate struct _SizeSpecification<T: Sized> : Specification {
  var size : Size
  func isSatisfied(item: T) -> Bool {
    return item.size == size
  }
}

fileprivate struct GenericFilter<T> : Filter {
  func filter<Spec>(items: [T], specs: Spec) -> [T] where Spec : Specification, T == Spec.T {
    var output = [T]()
    for item in items {
      if specs.isSatisfied(item: item) {
        output.append(item)
      }
    }
    return output
  }
}

fileprivate struct SomeView: View {
  let tree = Product(name: "tree", color: .green, size: .large)
  let frog = Product(name: "frog", color: .green, size: .small)
  let strawberry = Product(name: "strawberry", color: .red, size: .small)
  let small = _SizeSpecification<Product>(size: .small)

  var body: some View {
    VStack {
      Button("action") {
        let result = GenericFilter().filter(items: [tree, frog, strawberry], specs: small)
        print(result)
      }
    }
  }
}

// MARK: - Technique 4: Using protocol type for recursive design
//
fileprivate struct AndSpecification<T, SpecA: Specification, SpecB: Specification> : Specification where T == SpecA.T, T == SpecB.T {

  fileprivate var specA: SpecA
  fileprivate var specB: SpecB

  fileprivate init(specA: SpecA, specB: SpecB) {
    self.specA = specA
    self.specB = specB
  }

  func isSatisfied(item: T) -> Bool {
    return specA.isSatisfied(item: item) && specB.isSatisfied(item: item)
  }
}

