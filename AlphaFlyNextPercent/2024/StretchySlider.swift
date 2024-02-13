//
//  StretchySlider.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/02/10.
//
//  https://youtu.be/r1uxDHcGSaA?si=CEvV8GI9n4M80Y-K
//
//  2024 2/10 5:50
//  2024 2/12 9:30

import SwiftUI

fileprivate struct StretchySlider: View {
  enum SliderAxis {
    case vertical
    case horizontal
  }

  @Binding var sliderProgress: CGFloat

  var symbol: Symbol?
  var axis: SliderAxis
  var tint: Color

  @State private var progress: CGFloat = .zero
  @State private var dragOffset: CGFloat = .zero
  @State private var lastDragOffset: CGFloat = .zero

  var body: some View {
    GeometryReader {
      let size = $0.size
      let orientationSize = axis == .horizontal ? size.width : size.height
      let progressValue = (max(progress, .zero)) * orientationSize

      ZStack(alignment: axis == .horizontal ? .leading : .bottom) {
        Rectangle()
          .fill(.fill)

        Rectangle()
          .fill(tint)
          .frame(
            width: axis == .horizontal ? progressValue : nil,
            height: axis == .vertical ? progressValue : nil
          )

        if let symbol, symbol.display {
          Image(systemName: symbol.icon)
            .font(symbol.font)
            .foregroundStyle(symbol.tint)
            .padding(symbol.padding)
            .frame(width: size.width, height: size.height, alignment: symbol.alignment)
        }
      }
      .clipShape(.rect(cornerRadius: 15))
      .contentShape(.rect(cornerRadius: 15))
      .optionalSizingModifiers(
        axis: axis,
        size: size,
        progress: progress,
        orientationSize: orientationSize
      )
      .gesture(
        DragGesture(minimumDistance: 0)
          .onChanged {
            let translation = $0.translation
            let movement = (axis == .horizontal ?
              translation.width : -translation.height) + lastDragOffset
            dragOffset = movement
            calculateProgress(orientationSize: orientationSize)
          }
          .onEnded { _ in
            withAnimation(.smooth) {
              dragOffset = dragOffset > orientationSize ? orientationSize : ((dragOffset < 0) ? 0 : dragOffset)
              calculateProgress(orientationSize: orientationSize)
            }

            lastDragOffset = dragOffset
          }
      )
      .frame(
        maxWidth: size.width,
        maxHeight: size.height,
        alignment: (axis == .vertical) ? ((progress < 0) ? .top : .bottom) : ((progress < 0) ? .trailing : .leading)
      )
      .onChange(of: sliderProgress, initial: true) { oldValue, newValue in
        ///Initial Progress Setting
        guard sliderProgress != progress, ((sliderProgress > 0) && (sliderProgress < 1)) else { return }
        progress = max(min(sliderProgress, 1.0), .zero)
        dragOffset = progress * orientationSize
        lastDragOffset = dragOffset
      }
      .onChange(of: axis) { oldValue, newValue in
        dragOffset = progress * orientationSize
        lastDragOffset = dragOffset
      }
    }
    .onChange(of: progress) { oldValue, newValue in
      sliderProgress = max(min(progress, 1.0), .zero)
    }
  }
  
  private func calculateProgress(orientationSize: CGFloat) {
    let topAndTrailingExcessOffset = orientationSize + (dragOffset - orientationSize) * 0.1
    let bottomAndLeadingExcessOffset = (dragOffset < 0) ? (dragOffset * 0.1) : dragOffset

    let progress = ((dragOffset > orientationSize) ? topAndTrailingExcessOffset : bottomAndLeadingExcessOffset) / orientationSize

    self.progress = progress
  }

}

fileprivate extension View {
  @ViewBuilder
  func optionalSizingModifiers(
    axis: StretchySlider.SliderAxis,
    size: CGSize,
    progress: CGFloat,
    orientationSize: CGFloat
  ) -> some View {

    let topAndTrailingScale = 1 - ((progress - 1) * 0.4)
    let bottomAndLeadingScale = 1 + ((progress) * 0.4)

    self
      .frame(
        width: ((axis == .horizontal) && (progress < 0)) ?
        size.width + (-progress * size.width) : nil,
        height: ((axis == .vertical) && (progress < 0)) ?
          size.height + (-progress * size.height) : nil
      )
      .scaleEffect(
        x: (axis == .vertical) ?
        ((progress > 1) ?
            topAndTrailingScale
           :
            ((progress < 0) ? bottomAndLeadingScale : 1))
        :
          1,
        y: (axis == .horizontal) ?
        ((progress > 1) ?
            topAndTrailingScale
           :
            ((progress < 0) ? bottomAndLeadingScale : 1))
        :
          1,
        anchor: (axis == .horizontal) ? ((progress < 0) ? .trailing : .leading) : ((progress < 0) ? .top : .bottom)
      )
  }
}

fileprivate struct StretchySliderContainer: View {
  @State private var progress: CGFloat = 0.6
  @State private var axis: StretchySlider.SliderAxis = .vertical

  var body: some View {
    NavigationStack {
      VStack {
        Picker("", selection: $axis) {
          Text("Vertical")
            .tag(StretchySlider.SliderAxis.vertical)
          Text("Horizontal")
            .tag(StretchySlider.SliderAxis.horizontal)
        }
        .pickerStyle(.segmented)

        StretchySlider(
          sliderProgress: $progress,
          symbol: .init(
            icon: "airpodspro",
            tint: .gray,
            font: .system(size: 25),
            padding: 20,
            display: axis == .vertical,
            alignment: .bottom
          ),
          axis: axis,
          tint: .white
        )
        .frame(width: (axis == .horizontal) ? 220 : 60, height: (axis == .horizontal) ? 60 : 180)
        .frame(maxHeight: .infinity)
      }
      .padding()
      .frame(
        maxWidth: .infinity, maxHeight: .infinity, alignment: .top
      )
      .navigationTitle("Stretchy Slider")
      .background(.fill)
    }
  }
}

extension StretchySlider {
  fileprivate struct Symbol {
    var icon: String
    var tint: Color
    var font: Font
    var padding: CGFloat
    var display: Bool = false
    var alignment: Alignment = .center
  }
}

#Preview {
  StretchySliderContainer()
}
