//
//  ContentView.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/28.
//
//  https://youtu.be/mBAgCZJr6jw?si=bIvxe4fbZgaF0zx6

import SwiftUI
import WidgetKit
import ActivityKit

struct OrderView: View {
  var body: some View {
    NavigationStack {
      VStack {
        // MARK: Initialize Activity
        Button("Start Activity") {
          addLiveActivity()
        }
      }
      .navigationTitle("Live Activities")
      .padding(15)
    }
  }

  func addLiveActivity() {
    
  }
}
