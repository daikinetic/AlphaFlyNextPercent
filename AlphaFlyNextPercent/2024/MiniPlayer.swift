//
//  MiniPlayer.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/02/26.
//
//  2/27 Left MiniPlayerView
//  https://youtu.be/DtYDH4woWiY?si=aLS3zV2Xya79Rpad
//  https://www.patreon.com/posts/swiftui-youtube-99021298

import SwiftUI

struct MiniPlayerChildContainer: View {
  @State private var activeTab: Tab = .home
  @State private var config: PlayerConfig = .init()
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $activeTab) {

        HomeTabView()
          .setupTab(.home)
        Text(Tab.shorts.rawValue)
          .setupTab(.shorts)
        Text(Tab.subscriptions.rawValue)
          .setupTab(.subscriptions)
        Text(Tab.you.rawValue)
          .setupTab(.you)
      }
      .padding(.bottom, tabBarHeight)

      //MARK: MiniPlayerView
      GeometryReader {
        let size = $0.size

        if config.showMiniPlayer {
          MiniPlayerView(size: size, config: $config) {
            withAnimation(.spring, completionCriteria: .logicallyComplete) {
              config.showMiniPlayer = false
            } completion: {
              config.resetPosition()
              config.selectedPlayerItem = nil
            }
          }
        }
      }

      customTabBar()
        .offset(y: config.showMiniPlayer ? (tabBarHeight - (config.progress * tabBarHeight)) : 0)
    }
    .overlay(alignment: .top) {
      if config.showMiniPlayer {
        Rectangle()
          .fill(.black)
          .frame(height: safeArea.top)
          .opacity(config.showMiniPlayer ? (1.0 - (config.progress * 2)) : 0)
          .ignoresSafeArea()
      }
    }
    .ignoresSafeArea(.all, edges: .bottom)
  }

  //MARK: - HomeTabView
  @ViewBuilder
  func HomeTabView() -> some View {
    NavigationStack {
      ScrollView(.vertical) {
        LazyVStack(spacing: 15) {
          ForEach(items) { item in
            PlayerItemCardView(item) {
              config.selectedPlayerItem = item
              withAnimation(.spring()) {
                config.showMiniPlayer = true
              }
            }
          }
        }
        .padding(15)
      }
      .navigationTitle("YouTube")
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbarBackground(.background, for: .navigationBar)
    }
  }

  @ViewBuilder
  fileprivate func PlayerItemCardView(
    _ item: PlayerItem, onTap: @escaping () -> ()
  ) -> some View {
    VStack(alignment: .leading, spacing: 6) {
      Rectangle()
        .fill(item.color.gradient)
        .frame(height: 180)
        .clipShape(.rect(cornerRadius: 10))
        .contentShape(.rect)
        .onTapGesture(perform: onTap)
      HStack(spacing: 10) {
        Image(systemName: "person.circle.fill")
          .font(.title)

        VStack(alignment: .leading, spacing: 4) {
          Text(item.title)
            .font(.callout)
          HStack(spacing: 6) {
            Text(item.author)
            Text("· 2 Days Ago")
          }
          .font(.caption)
          .foregroundStyle(.gray)
        }
      }
    }
  }

  //MARK: - CustomTabBar
  func customTabBar() -> some View {
    HStack(spacing: 0) {
      ForEach(Tab.allCases, id: \.rawValue) { tab in
        VStack(spacing: 2) {
          Image(systemName: tab.symbol)
            .font(.title3)
            .scaleEffect(0.9, anchor: .bottom)

          Text(tab.rawValue)
            .font(.caption2)
        }
        .foregroundStyle((activeTab == tab) ? Color.primary : .gray)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(.rect)
        .onTapGesture {
          activeTab = tab
        }

      }
    }
    .frame(height: 49)
    .overlay(alignment: .top) {
      Divider()
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .frame(height: tabBarHeight)
    .background(.background)
  }

}

#Preview {
  MiniPlayerRootContainer()
}

//MARK: - Extension
extension View {
  // TabBarItem setUp function
  @ViewBuilder
  fileprivate func setupTab(_ tab: Tab) -> some View {
    self
      .tag(tab)
      .toolbar(.hidden, for: .tabBar)
  }

  // safeArea value
  fileprivate var safeArea: UIEdgeInsets {
    if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
      return safeArea
    }

    return .zero
  }

  // fixed tabBarHeight value
  fileprivate var tabBarHeight: CGFloat {
    49 + safeArea.bottom
  }
}

//MARK: - MiniPlayerView
fileprivate struct MiniPlayerView: View {
  var size: CGSize
  @Binding var config: PlayerConfig
  var close: () -> ()
  /// Player Configuration
  let miniPlayerHeight: CGFloat = 50
  let playerHeight: CGFloat = 200
  var body: some View {
    

    VStack(spacing: 0) {
      ZStack {
        //
      }
      .frame(minHeight: miniPlayerHeight, maxHeight: playerHeight)
      .zIndex(1)

      ScrollView(.vertical) {
        if let playerItem = config.selectedPlayerItem {
          PlayerExpandedContent(playerItem)
        }
      }
    }
  }

  @ViewBuilder
  func PlayerExpandedContent(_ item: PlayerItem) -> some View {
    VStack {
      //
    }
  }

}

//MARK: - Tab
fileprivate enum Tab: String, CaseIterable {
  case home = "Home"
  case shorts = "Shorts"
  case subscriptions = "Subscriptions"
  case you = "You"

  var symbol: String {
    switch self {

    case .home:
      "house.fill"
    case .shorts:
      "video.badge.waveform.fill"
    case .subscriptions:
      "play.square.stack.fill"
    case .you:
      "person.circle.fill"
    }
  }
}

//MARK: - Container
fileprivate struct MiniPlayerRootContainer: View {
  var body: some View {
    MiniPlayerChildContainer()
  }
}

//MARK: - PlayerConfig
fileprivate struct PlayerConfig: Equatable {
  var position: CGFloat = .zero
  var lastPosition: CGFloat = .zero
  var progress: CGFloat = .zero
  var selectedPlayerItem: PlayerItem?
  var showMiniPlayer: Bool = false

  mutating func resetPosition() {
    position = .zero
    lastPosition = .zero
    progress = .zero
  }
}

//MARK: - PlayerItem
fileprivate struct PlayerItem: Identifiable, Equatable {
  let id: UUID = .init()
  var title: String
  var author: String
  var image: String
  var description: String = dummyDescription
  var color: Color
}

// MARK: Sample Data
fileprivate let dummyDescription: String = {
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
}()
fileprivate var items: [PlayerItem] = [
  .init(
    title: "Apple Vision Pro - Unboxing, Review and demos!",
    author: "iJustine",
    image: "Pic 1",
    color: .red
  ),
  .init(
    title: "Hero Effect - SwiftUI",
    author: "Kavsoft",
    image: "Pic 1",
    color: .red
  ),
  .init(
    title: "What Apple Vision Pro is really like.",
    author: "iJustine",
    image: "Pic 1",
    color: .red
  ),
  .init(
    title: "Draggable Map Pin",
    author: "Kavsoft",
    image: "Pic 1",
    color: .red
  ),
  .init(
    title: "Maps Bottom Sheet",
    author: "Kavsoft",
    image: "Pic 1",
    color: .red
  ),
]
