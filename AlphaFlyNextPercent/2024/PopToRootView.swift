//
//  PopToRootView.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/02/14.
//
//  https://youtu.be/k5yyZ8R2Dig?si=HhhkAxT8Y2Gz38Jb
//  2024 2/14 1:00

import SwiftUI

struct PopToRootView: View {
  @State private var activeTab: Tab = .home
  var body: some View {
    TabView(selection: $activeTab) {
      NavigationStack {
        List {

        }
        .navigationTitle("Home")
      }
      .tag(Tab.home)
      .tabItem {
        Image(systemName: Tab.home.symbolImage)
        Text(Tab.home.rawValue)
      }

      NavigationStack {
        List {

        }
        .navigationTitle("Settings")
      }
      .tag(Tab.settings)
      .tabItem {
        Image(systemName: Tab.settings.symbolImage)
        Text(Tab.settings.rawValue)
      }

    }
  }
}

enum Tab: String {
  case home = "Home"
  case settings = "Settings"

  var symbolImage: String {
    switch self {
    case .home:
      "house"
    case .settings:
      "settings"
    }
  }
}

#Preview {
  PopToRootView()
}
