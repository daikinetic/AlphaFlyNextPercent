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

  @State var value: Int = 111

  var body: some View {
    NavigationView {
      VStack {
        RollingText(
          font: .system(size: 55),
          weight: .black,
          value: $value
        )
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
      ForEach(0..<animationRange.count, id: \.self) { _ in
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
            }
          }
      }
    }
  }
}






























