//
//  HandSpinner.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/15.
//

import Foundation
import SwiftUI

struct ContentView: View {

  @State private var angle: Double = 0

  @State private var acceleration: Double = 0

  private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

  var body: some View {
    Image(systemName: "fanblades.fill")
      .resizable()
      .frame(width: 300, height: 300)
      .rotationEffect(.degrees(angle))
      .gesture(
        DragGesture()
          .onChanged { value in
            // 加速度を更新
            acceleration += value.translation.height / 10
          }
      )
      .onReceive(timer) { _ in
        // 減速させる
        acceleration += -(acceleration * 0.01)
        // 角度を更新
        angle += acceleration
      }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
