//
//  _LazyTrain.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/01/24.
//
//  https://qiita.com/shiz/items/782979bd8a539c9d2291

import Foundation
import UIKit

fileprivate final class Calendar {
  private lazy var formatterLazy: DateFormatter = {
    sleep(5)
    print("call - lazy")
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.locale = Locale.init(identifier: "ja_JP")
    return formatter
  }()

  private static var formatterStatic: DateFormatter = {
    sleep(5)
    print("call - static")
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.locale = Locale.init(identifier: "ja_JP")
    return formatter
  }()

  var todayLazy: String {
    formatterLazy.string(from: Date())
  }

  var todayStatic: String {
    Calendar.formatterStatic.string(from: Date())
  }
}

final class CalendarInitializer: UIViewController {

  //MARK: - Properties

  //MARK: - Initializer
  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Functions
  override func viewDidLoad() {

    let q1 = DispatchQueue(label: "1")
    let q2 = DispatchQueue(label: "2")

    let c = Calendar()
    q1.async { print("QQQ: \(c.todayLazy)") }
    q2.async { print("QQQ: \(c.todayLazy)") }
    
    q1.async { print("QQQ: \(c.todayStatic)") }
    q2.async { print("QQQ: \(c.todayStatic)") }
  }
}

// NOTE:
//   If a property marked with the lazy modifier is accessed by multiple threads simultaneously
//   and the property has not yet been initialized,
//   there is no guarantee that the property will be initialized only once.

// NOTE:
//   Stored type properties are lazily initialized on their first access.
//   They are guaranteed to be initialized only once,
//   even when accessed by multiple threads simultaneously,
//   and they do not need to be marked with the lazy modifier.

