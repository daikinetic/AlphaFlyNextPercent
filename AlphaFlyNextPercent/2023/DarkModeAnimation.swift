//
//  DarkModeAnimation.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/01.
//
//  https://youtu.be/4dbnfyXILc4?si=Dpl5kZd0-Moyxk-7

import SwiftUI

struct DarkModeAnimation: View {
  @State private var activeTab: Int = 0
  @State private var toggles: [Bool] = Array(repeating: false, count: 10)

  var body: some View {
    TabView(selection: $activeTab) {
      NavigationStack {
        List {
          Section("Text Section") {
            Toggle("Large Display", isOn: $toggles[0])
            Toggle("Bold Text", isOn: $toggles[1])
          }

          Section {
            Toggle("Night Light", isOn: $toggles[2])
            Toggle("True Tone", isOn: $toggles[3])
          } header: {
            Text("Display Section")
          } footer: {
            Text("This is a Sample Footer.")
          }
        }
        .navigationTitle("Dark Mode")
      }
      .tabItem {
        Image(systemName: "house")
        Text("Home")
      }

      Text("Settings")
        .tabItem {
          Image(systemName: "gearshape")
          Text("Settings")
        }
    }

  }
}

#Preview {
  DarkModeAnimation()
}
