//
//  ConfigDemo.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/25.
//
//  https://x.com/timsneath/status/1705304825666339037?s=20

import SwiftUI

struct ConfigDemo: View {
  @State private var stepperValue = 11
  @State private var switchSetting = true
  @State private var dateValue = Date.now

  var body: some View {
    NavigationView {
      Form {
        Section {
          Toggle("On or off: you choose", isOn: $switchSetting)
          Stepper(value: $stepperValue, in: 0...11) {
            Text("Awesomeness: \(stepperValue)")
          }
          DatePicker(selection: $dateValue, label: { Text("Date") })
        } 
        header: {
          Text("First Section")
        } 
        footer: {
          Text("This section contains some useful settings")
        }

        Section {
          Text("Hello, world!")
          Text("Hello, world!")
          Text("Hello, world!")
          Text("Hello, world!")
        } 
        header: {
          Text("Second Section")
        }
      }
      .navigationTitle("SwiftUI Config Demo")
    }
  }
}

#Preview {
  ConfigDemo()
}
