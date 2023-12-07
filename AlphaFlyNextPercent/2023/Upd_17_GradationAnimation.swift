//
//  Upd_17_GradationAnimation.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/12/07.
//
//  https://qiita.com/SNQ-2001/items/cf96ee41f5c8adca4715

import SwiftUI

struct Upd_17_GradationAnimation: View {

  @State private var gradient = LinearGradient(
    colors: [.black],
    startPoint: .top,
    endPoint: .bottom
  )

  var body: some View {
    VStack {
      Button {
        withAnimation {
          gradient = LinearGradient(
            colors: [
              Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
              Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
            ],
            startPoint: .top,
            endPoint: .bottom
          )
        }
      } label: {
        Text("変更")
      }
    }
    .ignoresSafeArea()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Rectangle().foregroundStyle(gradient))
  }
}

#Preview {
  Upd_17_GradationAnimation()
}
