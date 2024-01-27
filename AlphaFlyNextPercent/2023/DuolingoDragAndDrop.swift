//
//  DuolingoDragAndDrop.swift
//  
//
//  Created by Daiki Takano on 2024/01/28.
//
//  https://youtu.be/owo6Xtvad4c?si=MOHQ-mrW8dBG1APc
//
//  2024 1/28 3:05

import SwiftUI

fileprivate struct DuolingoDragAndDrop: View {

  @State var progress: CGFloat = 0
  var body: some View {
    VStack(spacing: 15) {
      NavBar()

      VStack(alignment: .leading, spacing: 30) {
        Text("Form this sentence")
          .font(.title2.bold())

        Image("desi")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(.trailing, 100)
      }
      .padding(.top, 30)
    }
    .padding()
  }

  @ViewBuilder
  func NavBar() -> some View {
    HStack(spacing: 18) {
      Button {

      } label: {
        Image(systemName: "xmark")
          .font(.title3)
          .foregroundColor(.gray)
      }

      GeometryReader { proxy in
        ZStack(alignment: .leading) {
          Capsule()
            .fill(.gray.opacity(0.25))

          Capsule()
            .fill(.green)
            .frame(width: proxy.size.width * progress)
        }
      }
      .frame(height: 20)

      Button {

      } label: {
        Image(systemName: "suit.heart.fill")
          .font(.title3)
          .foregroundColor(.red)
      }
    }
  }
}

#Preview {
  ZakoView()
}

fileprivate struct ZakoView: View {
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      DuolingoDragAndDrop()
    }
  }
}

struct Character: Identifiable, Hashable, Equatable {
  var id = UUID().uuidString
  var value: String
  var padding: CGFloat = 10
  var textSize: CGFloat = .zero
  var fontSize: CGFloat = 19
  var isShowing: Bool = false
}

var characters_: [Character] = [
  Character(value: "Lorem"),
  Character(value: "Ipsum"),
  Character(value: "is"),
  Character(value: "simply"),
  Character(value: "dummy"),
  Character(value: "text"),
  Character(value: "of"),
  Character(value: "the"),
  Character(value: "design"),
]
