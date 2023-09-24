//
//  Toggle.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/24.
//
//  https://x.com/amos_gyamfi/status/1705377973367689428?s=20

import SwiftUI

@available(iOS 17.0, *)
struct ToggleContentTransition: View {

  @State var audioOn: Bool = false
  @State var videoOn: Bool = false

  var body: some View {

    HStack(spacing: 80) {
      Toggle(isOn: $audioOn) {
        Image(systemName: audioOn ? "mic.fill" : "mic.slash.fill")
          .symbolRenderingMode(.hierarchical)
          .foregroundColor(audioOn ? .green : .primary)
          .contentTransition(.symbolEffect(.replace))
      }
      .frame(width: 80)

      Toggle(isOn: $videoOn) {
        Image(systemName: videoOn ? "video.fill" : "video.slash.fill")
          .symbolRenderingMode(.hierarchical)
          .foregroundColor(videoOn ? .green : .primary)
          .contentTransition(.symbolEffect(.replace))
      }
      .frame(width: 80)
    }
  }
}

#Preview {
  ToggleContentTransition()
}
