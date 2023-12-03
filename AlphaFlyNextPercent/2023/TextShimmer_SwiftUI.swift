//
//  TextShimmer_SwiftUI.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/12/03.
//
//  https://youtu.be/KYokxl1inRs

import SwiftUI

struct TextShimmer_SwiftUI: View {
    var body: some View {
      Home()
    }
}

#Preview {
    TextShimmer_SwiftUI()
}

fileprivate struct Home: View {

  var body: some View {
    VStack(spacing: 25) {
      TextShimmer(text: "AlphaFly")
      TextShimmer(text: "NextPercent")
    }
    .preferredColorScheme(.dark)
  }
}

fileprivate struct TextShimmer: View {

  var text: String

  var body: some View {
    ZStack {

      Text(text)
        .font(.system(size: 64, weight: .bold))
        .foregroundColor(.white.opacity(0.25))
    }
  }
}
