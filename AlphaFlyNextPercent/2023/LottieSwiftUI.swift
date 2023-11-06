//
//  LottieSwiftUI.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/06.
//
//  https://github.com/airbnb/lottie-ios

//import SwiftUI
//import Lottie
//
//struct LottieSwiftUI: View {
//
//  @State var playbackMode = LottiePlaybackMode.playing(.fromFrame(.infinity, toFrame: .infinity, loopMode: .repeat(.infinity)))
//
//  var body: some View {
//    NavigationStack {
//      VStack {
//        Text("Hello, World")
//          .padding()
//
//        LottieView(loopMode: .repeat(.infinity))
//          .playbackMode(playbackMode)
//          .animationDidFinish { _ in
//            playbackMode = .paused
//          }
//
//        Button {
//          playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
//        } label: {
//          Image(systemName: "play.fill")
//        }
//
//      }
//      .navigationTitle("Lottie")
//      .padding()
//    }
//  }
//}

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: "Car")
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}

import SwiftUI

struct LottyView: View {
    var body: some View {
      NavigationStack {
        VStack {
          LottieView(loopMode: .loop)
              .scaleEffect(1)
        }
        .navigationTitle("Lottie Car")
      }
    }
}

struct LottyView_Previews: PreviewProvider {
    static var previews: some View {
        LottyView()
    }
}

//#Preview {
//  LottieSwiftUI()
//}
