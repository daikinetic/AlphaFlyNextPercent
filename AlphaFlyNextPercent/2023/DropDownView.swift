//
//  DropDownView.swift
//  Pods
//
//  Created by Daiki Takano on 2024/01/21.
//
//  https://youtu.be/1g2OymIXtPY?si=mDqheRuuYk9H8WoQ
//
//  2024 1/21 5:15

import SwiftUI

fileprivate struct DropDownView: View {
  var hint: String
  var options: [String]
  var anchor: Anchor = .bottom
  var maxWidth: CGFloat = 180
  var cornerRadius: CGFloat = 15
  @Binding var selection: String?
  @State private var showOptions: Bool = false
  @Environment(\.colorScheme) private var scheme
  var body: some View {
    GeometryReader {
      let size = $0.size

      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Text(selection ?? hint)
            .foregroundStyle(selection == nil ? .gray : .primary)
            .lineLimit(1)

          Spacer(minLength: 0)

          Image(systemName: "chevron.down")
            .font(.title3)
            .foregroundStyle(.gray)
            .rotationEffect(.init(degrees: showOptions ? -180 : 0))
        }
        .padding(.horizontal, 15)
        .frame(width: size.width, height: size.height)
        .contentShape(.rect)
        .onTapGesture {
          withAnimation(.snappy) {
            showOptions.toggle()
          }
        }

        if showOptions {
          OptionsView()
        }
      }
      .background(
        (scheme == .dark ? Color.black : Color.white)
          .shadow(.drop(color: .primary.opacity(0.15), radius: 4)),
        in: .rect(cornerRadius: cornerRadius)
      )
    }
    .frame(width: maxWidth, height: 50)
  }

  @ViewBuilder
  func OptionsView() -> some View {
    VStack(spacing: 10) {
      ForEach(options, id: \.self) { option in
        HStack(spacing: 0) {
          Text(option)
            .lineLimit(1)

          Spacer(minLength: 0)

          Image(systemName: "checkmark")
            .opacity(selection == option ? 1 : 0)
        }
        .foregroundStyle(
          selection == option ? Color.primary : Color.gray
        )
        .animation(.none, value: selection)
        .frame(height: 40)
        .contentShape(.rect)
        .onTapGesture {
          withAnimation(.snappy) {
            selection = option
            showOptions = false
          }
        }
      }
    }
    .padding(.horizontal, 15)
  }

  enum Anchor {
    case top
    case bottom
  }
}

fileprivate struct DropDownViewContainer: View {
  @State private var selection: String?
  var body: some View {
    NavigationStack {
      VStack(spacing: 15) {
        DropDownView(
          hint: "Select",
          options: [
            "YouTube",
            "Instagram",
            "X",
            "Snapchat",
            "Tiktok"
          ],
          selection: $selection
        )
      }
      .navigationTitle("Dropdown Picker")
    }
  }
}

#Preview {
  DropDownViewContainer()
}
