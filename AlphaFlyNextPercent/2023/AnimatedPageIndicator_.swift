//
//  AnimatedPageIndicator_.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/01/14.
//
//  https://youtu.be/hvD_AafLGc0?si=iA79-YBmtiVHoBbr

import Foundation
import SwiftUI

fileprivate struct AnimatedPageIndicator: View {

  @State private var colors: [Color] = [.red, .blue, .green, .yellow]
  @State private var opacityEffect: Bool = false
  @State private var clipEdges: Bool = false
  var body: some View {
    NavigationStack {
      VStack {
        ScrollView(.horizontal) {
          LazyHStack(spacing: 0) {
            ForEach(colors, id: \.self) { color in
              RoundedRectangle(cornerRadius: 25)
                .fill(color.gradient)
                .padding(.horizontal, 15)
                .containerRelativeFrame(.horizontal)
            }
          }
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        .frame(height: 220)
        .padding(.top, 15)

        List {
          Section("Options") {
            Toggle("Opacity Effect", isOn: $opacityEffect)
            Toggle("Clip Edges", isOn: $clipEdges)

            Button("Add Item") {
              colors.append(.purple)
            }
          }
        }
      }
      .navigationTitle("Custom Indicator")
    }
  }

}

#Preview {
  AnimatedPageIndicator()
}
