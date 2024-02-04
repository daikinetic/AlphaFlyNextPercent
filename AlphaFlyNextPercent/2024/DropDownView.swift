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
  @SceneStorage("drop_down_zindex") private var index = 1000.0
  @State private var zIndex: Double = 1000.0
  var body: some View {
    GeometryReader {
      let size = $0.size

      VStack(spacing: 0) {

        if showOptions && anchor == .top {
          OptionsView()
        }

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
        .background(scheme == .dark ? .black : .white)
        .contentShape(.rect)
        .onTapGesture {
          index += 1
          zIndex = index
          withAnimation(.snappy) {
            showOptions.toggle()
          }
        }
        .zIndex(10)

        if showOptions && anchor == .bottom {
          OptionsView()
        }
      }
      .clipped()
      /// Clips All Interaction within it's bounds
      .contentShape(.rect)
      .background(
        (scheme == .dark ? Color.black : Color.white)
          .shadow(.drop(color: .primary.opacity(0.15), radius: 4)),
        in: .rect(cornerRadius: cornerRadius)
      )
      .frame(height: size.height, alignment: anchor == .top ? .bottom : .top)
    }
    .frame(width: maxWidth, height: 50)
    .zIndex(zIndex)
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
            .font(.caption)
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
    .padding(.vertical, 5)
    .transition(.move(edge: anchor == .top ? .bottom : .top))
  }

  enum Anchor {
    case top
    case bottom
  }
}

fileprivate struct DropDownViewContainer: View {
  @State private var selection: String?
  @State private var selection1: String?
  @State private var selection2: String?
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
          anchor: .bottom,
          selection: $selection
        )

        DropDownView(
          hint: "Select",
          options: [
            "Short Form",
            "Long Form",
            "Both"
          ],
          anchor: .top,
          selection: $selection1
        )

        DropDownView(
          hint: "Select",
          options: [
            "Education",
            "Tech",
            "History",
            "Others"
          ],
          anchor: .top,
          selection: $selection2
        )

        Button("I'm Button") {

        }
      }
      .navigationTitle("Dropdown Picker")
    }
  }
}

#Preview {
  DropDownViewContainer()
}
