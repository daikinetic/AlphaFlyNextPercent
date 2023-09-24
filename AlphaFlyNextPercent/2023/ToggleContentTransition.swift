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
    VStack {
      Circle()
        .frame(width: 180)
        .overlay {
          Image("mountain")
            .resizable()
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
        .foregroundColor(.white)
        .padding(.bottom, 70)

      Text("Set how you would like to join the meeting")
        .foregroundColor(.white)
        .padding(.bottom, 80)

      HStack(spacing: 80) {
        Toggle(isOn: $audioOn) {
          Image(systemName: audioOn ? "mic.fill" : "mic.slash.fill")
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(audioOn ? .green : .gray)
            .contentTransition(.symbolEffect(.replace))
        }
        .frame(width: 70)

        Toggle(isOn: $videoOn) {
          Image(systemName: videoOn ? "video.fill" : "video.slash.fill")
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(videoOn ? .green : .gray)
            .contentTransition(.symbolEffect(.replace))
        }
        .frame(width: 80)
      }
      .padding(.bottom, 80)


      Button(
        action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
        label: {
          Text("Join muted")
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(24)
            .padding(.horizontal, 80)
        }
      )
      .frame(height: 65)
      .frame(maxWidth: .infinity)
      .foregroundColor(.blue)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background {
      Color.black
    }
    .ignoresSafeArea(.all)
  }
}

#Preview {
  ToggleContentTransition()
}
