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

  /// Navigation Paths
  @State private var homeStack: NavigationPath = .init()
  @State private var settingsStack: NavigationPath = .init()
  @State private var tapCount: Int = .zero

  var body: some View {
    TabView(selection: tabSelection) {
      NavigationStack(path: $homeStack) {
        List {
          NavigationLink("Detail", value: "Detail")
        }
        .navigationTitle("Home")
        .navigationDestination(for: String.self) { value in
          List {
            if value == "Detail" {
              NavigationLink("More", value: "More")
            }
          }
          .navigationTitle(value)
        }
      }
      .tag(Tab.home)
      .tabItem {
        Image(systemName: Tab.home.symbolImage)
        Text(Tab.home.rawValue)
      }

      NavigationStack(path: $settingsStack) {
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

  var tabSelection: Binding<Tab> {
    return .init(
      get: {
        activeTab
      },
      set: { newValue in

        if newValue == activeTab {
          /// Same Tab Clicked Once Again
          tapCount += 1

          if tapCount == 2 {
            switch newValue {
            case .home:
              homeStack = .init()
            case .settings:
              settingsStack = .init()
            }

            tapCount = .zero
          }

        } else {
          tapCount = .zero
        }

        activeTab = newValue
      }
    )
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
