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
      .padding(.horizontal, 10)
      .padding(.vertical, 10)
      .background {
        (colorScheme == .dark ? Color.black : Color.white).opacity(isFocused ? 0 : 1)
        Rectangle()
          .cornerRadius(5)
      }
  }


}

struct TagField_Previews: PreviewProvider {
  static var previews: some View {
    TagTextFieldContentView()
  }
}
