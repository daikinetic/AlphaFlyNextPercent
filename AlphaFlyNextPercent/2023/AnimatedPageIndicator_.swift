//
//  AnimatedPageIndicator_.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/01/14.
//
//  https://youtu.be/hvD_AafLGc0?si=iA79-YBmtiVHoBbr
//
//  2:35 1/14 

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
                .padding(.horizontal, 5)
                .containerRelativeFrame(.horizontal)
            }
          }
          .scrollTargetLayout()
          .overlay(alignment: .bottom) {
            PagingIndicator(
              activeTint: .white,
              inActiveTint: .black.opacity(0.25),
              opacityEffect: opacityEffect,
              clipEdges: clipEdges
            )
          }
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .frame(height: 220)
        .safeAreaPadding(.vertical, 15)
        .safeAreaPadding(.horizontal, 25)

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

fileprivate struct PagingIndicator: View {
  var activeTint: Color = .primary
  var inActiveTint: Color = .primary.opacity(0.15)
  var opacityEffect: Bool = false
  var clipEdges: Bool = false
  var body: some View {
    GeometryReader {
      ///Entire View Size for Calculating Pages
      let width = $0.size.width

      if let scrollViewWidth = $0.bounds(of: .scrollView(axis: .horizontal))?.width, scrollViewWidth > 0 {

        let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
        let totalPages = Int(width / scrollViewWidth)
        ///Progress
        let freeProgress = -minX / scrollViewWidth
        let clippedProgress = min(max(freeProgress, 0.0), CGFloat(totalPages - 1))
        let progress = clipEdges ? clippedProgress : freeProgress
        ///Indexes
        let activeIndex = Int(progress)
        let nextIndex = Int(progress.rounded(.awayFromZero))
        let indicatorProgress = progress - CGFloat(activeIndex)
        ///Indicator Width's (Current & Upcoming)
        let currentPageWidth = 18 - (indicatorProgress * 18)
        let nextPageWidth = indicatorProgress * 18

        HStack() {
          ForEach(0..<totalPages, id: \.self) { index in
            Capsule()
              .fill(inActiveTint)
              .frame(
                width: 8 + ((activeIndex == index) ? currentPageWidth : (nextIndex == index) ? nextPageWidth : 0),
                height: 8
              )
              .overlay {
                ZStack {
                  Capsule()
                    .fill(inActiveTint)

                  Capsule()
                    .fill(activeTint)
                    .opacity(
                      opacityEffect ? (activeIndex == index) ? (1 - indicatorProgress) : (nextIndex == index) ? indicatorProgress : 0 : 1
                    )
                }
              }
          }
        }
        .frame(width: scrollViewWidth)
        .offset(x: -minX)
      }

    }
    .frame(height: 30)
  }
}
