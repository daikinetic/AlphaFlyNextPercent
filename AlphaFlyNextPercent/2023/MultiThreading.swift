//
//  MultiThreading.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/22.
//
//  https://medium.com/@ganeshrajugalla/swiftui-multithreading-7f0988af5c7c

import SwiftUI

struct MultiThreading: View {
  @StateObject var viewModel = ViewModel()

  var body: some View {
    ScrollView(showsIndicators: false) {
      LazyVStack {
        Text("Load Data")
          .padding()
          .frame(height: 50)
          .foregroundColor(.white)
          .background(.green)
          .cornerRadius(10)
          .onTapGesture {
            viewModel.fetchData()
          }

        ForEach(viewModel.dataArray, id: \.self) { item in
          Text(item)
            .font(.headline)
            .foregroundColor(.blue)
        }
      }
    }
  }
}

struct MultiThreading_Previews: PreviewProvider {
  static var previews: some View {
    MultiThreading()
  }
}

// MARK: ViewModel

import Foundation

class ViewModel: ObservableObject {
  @Published var dataArray: [String] = []

  func fetchData() {
    DispatchQueue.global(qos: .background).async {
      print("Check 1: - \(Thread.isMainThread)")
      print("Check 1: - \(Thread.current)")
      let newData = self.downloadData()

      DispatchQueue.main.async {
        print("Check 2: - \(Thread.isMainThread)")
        print("Check 2: - \(Thread.current)")
        self.dataArray = newData
      }
    }
  }

  func downloadData() -> [String] {
    var data:[String] = []

    for str in 0..<100{
      data.append("\(str)")
    }
    return data
  }
}
