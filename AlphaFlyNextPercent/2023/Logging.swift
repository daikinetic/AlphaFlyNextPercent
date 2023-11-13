//
//  Logging.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/11.
//
//  https://swiftwithmajid.com/2022/04/06/logging-in-swift/

import Foundation
import os
import SwiftUI

@MainActor final class ProductsViewModel: ObservableObject {
  private static let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: ProductsViewModel.self)
  )

  @Published private(set) var products: [Product] = []

  private let service: Service_Private

  init(service: Service_Private) {
    self.service = service
  }

  func fetch() async {
    do {
      Self.logger.trace("Start product list fetching")
      products = try await service.fetch()
    } catch {
      Self.logger.warning("\(error.localizedDescription, privacy: .public)")
    }
  }

//  func save_log(_ object: CKRecord, using container: CKContainer) async {
//    do {
//      let status = try await container.accountStatus()
//    } catch {
//      Self.logger.critical("Can't fetch iCloud account status")
//      fatalError()
//    }
//  }

}

struct LoggedView: View {

  private static let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: LoggedView.self)
  )

  @State private var counter: UInt = 1_000
  @Environment(\.scenePhase)
  private var scenePhase

  var body: some View {
    Text("Hello!")
      .onChange(of: scenePhase) { newPhase in
//        Self.logger.trace("Scene phase: \(newPhase, privacy: .public)")
        Self.logger.trace("Counter: \(counter, privacy: .private(mask: .hash))")
        Self.logger.trace("Counter: \(counter, align: .right(columns: 10))")
        Self.logger.trace("Counter: \(counter, format: .hex, align: .right(columns: 10))")
      }
  }
}

struct Service_Private {
  func fetch() -> [Product] {
    print("loading...")
    return [Product.init(title: "aa", revenue: 120)]
  }
}
