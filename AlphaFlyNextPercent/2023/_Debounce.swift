//
//  _Debounce.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/25.
//
//  https://x.com/BigMtnStudio/status/1727666479196156384?s=20

import Foundation
import SwiftUI

fileprivate final class DebounceViewModel: ObservableObject {
  @Published var name = ""
  @Published var nameEntered = ""

  init() {
    $name
      .debounce(for: 0.5, scheduler: RunLoop.main) // work done on the main thread
      .assign(to: &$nameEntered) // pipeline で delay を挟む
  }
}

fileprivate struct Debounce_Intro: View {
  @StateObject private var vm = DebounceViewModel()

  var body: some View {
    VStack {
      HeaderView(
        "Debounce",
        subtitle: "Introduction",
        desc: "The debounce operator can pause items going through your pipeline for a specified amount of time"
      )

      TextField("name", text: $vm.name)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .font(.title2)

      Text("\(vm.nameEntered)")


      Spacer()
    }
    .font(.title)
    .safeAreaPadding(.all)
  }
}

#Preview {
  Debounce_Intro()
}

fileprivate struct HeaderView: View {

  let title: String
  let subtitle: String
  let desc: String

  init(_ title: String , subtitle: String, desc: String) {
    self.title = title
    self.subtitle = subtitle
    self.desc = desc
  }

  var body: some View {
    VStack {
      Text("\(title)")
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding(.bottom, 8)

      Text("\(subtitle)")
        .font(.title2)
        .padding(.bottom, 8)

      Text("\(desc)")
        .font(.title2)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
  }
}
