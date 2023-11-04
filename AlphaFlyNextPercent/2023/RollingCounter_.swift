//
//  RollingCounter_.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/04.
//
//  https://youtu.be/NkssjWSmzIg?si=yC0oCJFvDQ0w4TRg

import SwiftUI

#Preview {
  RollingCounter_()
}

struct RollingCounter_: View {

  @State var value: Int = 0

  var body: some View {
    NavigationView {
      VStack(spacing: 25) {
        RollingText(font: .system(size: 55), weight: .black, value: $value)

        Button("Change Value") {
          value = .random(in: 0...2000)
        }
      }
      .padding()
      .navigationTitle("Rolling Counter")
    }
  }
}

struct RollingText: View {

  var font: Font = .largeTitle
  var weight: Font.Weight = .regular
  @Binding var value: Int

  @State var animationRange: [Int] = []

  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<animationRange.count, id: \.self) { index in
        Text("8")
          .font(font).fontWeight(weight).opacity(0)
          .overlay {
            GeometryReader { proxy in
              let size = proxy.size

              VStack(spacing: 0) {
                ForEach(0...9, id: \.self) { number in
                  Text("\(number)")
                    .font(font).fontWeight(weight)
                    .frame(width: size.width, height: size.height, alignment: .center)
                }
              }
              // Offset
              .offset(y: -CGFloat(animationRange[index]) * size.height)
            }
            .clipped()
          }
      }
    }
    .onAppear {
      animationRange = Array(repeating: 0, count: "\(value)".count)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
        updateText()
      }
    }
    .onChange(of: value) { newValue in

      let extra = "\(value)".count - animationRange.count
      if extra > 0 {
        for _ in 0..<extra {
          withAnimation(.easeIn(duration: 0.1)) { animationRange.append(0) }
        }
      } else {
        for _ in 0..<(-extra) {
          withAnimation(.easeIn(duration: 0.1)) { animationRange.removeLast() }
        }
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
        updateText()
      }
    }
  }

  func updateText() {
    let stringValue = "\(value)"
    for (index, value) in zip(0..<stringValue.count, stringValue) {
      //if first value = 1, then offset will be applied for -1,
      //so the text will move up to show 1 value

      var fraction = Double(index) * 0.15
      fraction = (fraction > 0.5 ? 0.5 : fraction)

      withAnimation(.interactiveSpring(
          response: 0.8, dampingFraction: 1, blendDuration:  1
        )
      ) {
        animationRange[index] = (String(value) as NSString).integerValue
      }
    }
  }
}






























