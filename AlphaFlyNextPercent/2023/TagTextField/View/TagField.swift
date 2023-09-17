//
//  TagField.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/18.
//

import SwiftUI

struct TagField: View {
  @Binding var tags: [Tag]
  var body: some View {
    HStack {
      ForEach($tags) { $tag in
        TagView(tag: $tag, allTags: $tags)
          .onChange(of: tag.value) { newValue in
            if newValue.last == "," {
              // Removi Commma
              tag.value.removeLast()
              // Insert New Tag Item
              tags.append(.init(value: ""))
            }
          }
      }
    }
    .padding(.vertical, 10)
    .padding(.horizontal, 15)
    .background(.bar, in: RoundedRectangle(cornerRadius: 12))
    .onAppear {
      if tags.isEmpty {
        tags.append(.init(value: "", isInitial: true))
      }
    }
  }
}

fileprivate struct TagView: View {
  //MARK: - Properties
  @Binding var tag: Tag
  @Binding var allTags: [Tag]
  @FocusState private var isFocused: Bool

  @Environment(\.colorScheme) private var colorScheme

  //
  var body: some View {
    TextField("Tag", text: $tag.value)
      .focused($isFocused)
      .padding(.horizontal, isFocused || tag.value.isEmpty ? 0 : 10)
      .padding(.vertical, 10)
      .background (
        (colorScheme == .dark ? Color.black : Color.white).opacity(isFocused || tag.value.isEmpty ? 0 : 1),
        in: RoundedRectangle(cornerRadius: 5)
      )
      .disabled(tag.isFocused)
      .overlay {
        if tag.isInitial {
          RoundedRectangle(cornerRadius: 5)
            .fill(.clear)
            .onTapGesture {
              tag.isInitial = false
              isFocused = true
            }

        }
      }
  }


}

struct TagField_Previews: PreviewProvider {
  static var previews: some View {
    TagTextFieldContentView()
  }
}
