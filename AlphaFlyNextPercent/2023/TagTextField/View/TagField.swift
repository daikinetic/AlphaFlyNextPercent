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
        Text(tag.value)
      }
    }
  }
}

fileprivate struct TagView: View {
  //MARK: - Properties
  @Binding var tag: Tag
  @Binding var allTags: [Tag]
  @FocusState private var isFocused: Bool

  //
  var body: some View {
    TextField("Tag", text: $tag.value)
  }


}

struct TagField_Previews: PreviewProvider {
  static var previews: some View {
    TagTextFieldContentView()
  }
}
