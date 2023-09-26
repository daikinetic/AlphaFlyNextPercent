//
//  ScrollTransition.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/26.
//
//  https://x.com/FloWritesCode/status/1706381651566035263?s=20

import SwiftUI

struct ListItem: Identifiable {
  let id = UUID()
  let title: String
  let color: Color

  static let preview: [ListItem] = [
    ListItem(title: "Row1", color: .red),
    ListItem(title: "Row2", color: .blue),
    ListItem(title: "Row3", color: .green),
    ListItem(title: "Row4", color: .orange),
    ListItem(title: "Row5", color: .pink)
  ]
}

struct ScrollTransition: View {

  var body: some View {
    ScrollView {
      ForEach(ListItem.preview) { item in
        item.color
          .frame(height: 300)
          .overlay {
            Text(item.title)
          }
          .cornerRadius(16)
          .padding(.horizontal)
          .scrollTransition { effect, phase in
            effect
              .scaleEffect(phase.isIdentity ? 1 : 0.8)
              .offset(x: offset(for: phase))
          }
      }
    }
  }

  func offset(for phase: ScrollTransitionPhase) -> Double {
    switch phase {
    case .topLeading:
      -200
    case .identity:
      0
    case .bottomTrailing:
      200
    }
  }

}

#Preview {
  ScrollTransition()
}
