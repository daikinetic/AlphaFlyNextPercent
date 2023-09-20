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
    TagLayout(alignment: .leading) {
      ForEach($tags) { $tag in
        TagView(tag: $tag, allTags: $tags)
          .onChange(of: tag.value) { newValue in
            if newValue.last == "," {
              // Remove Commma
              tag.value.removeLast()
              // Insert New Tag Item
              if !tag.value.isEmpty {
                // Safe check
                tags.append(.init(value: ""))
              }
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
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
      if let lastTag = tags.last, !lastTag.value.isEmpty {
        // Insert empty tag at last
        tags.append(.init(value: "", isInitial: true))
      }
    })
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
    BackSpaceListenerTextField(hint: "Tag", text: $tag.value) {
      if allTags.count > 1 {
        if tag.value.isEmpty {
          allTags.removeAll(where: { $0.id == tag.id })
          // Activating the previously available Tag
          if let lastIndex = allTags.indices.last {
            allTags[lastIndex].isInitial = false
          }
        }
      }
    }
    .focused($isFocused)
    .padding(.horizontal, isFocused || tag.value.isEmpty ? 0 : 10)
    .padding(.vertical, 10)
    .background (
      (colorScheme == .dark ? Color.black : Color.white).opacity(isFocused || tag.value.isEmpty ? 0 : 1),
      in: RoundedRectangle(cornerRadius: 5)
    )
    .disabled(tag.isFocused)
    .onChange(of: allTags) { newValue in
      if newValue.last?.id == tag.id && !(newValue.last?.isInitial ?? false) && !isFocused {
        isFocused = true
      }
    }
    .overlay {
      if tag.isInitial {
        RoundedRectangle(cornerRadius: 5)
          .fill(.clear)
          .onTapGesture {
            // Activating only for last Tag
            if allTags.last?.id == tag.id {
              tag.isInitial = false
              isFocused = true
            }
          }
      }
    }
    .onChange(of: isFocused) { _ in
      if !isFocused {
        tag.isInitial = true
      }
    }
  }
}

fileprivate struct BackSpaceListenerTextField: UIViewRepresentable {
  var hint: String = "Tag"
  @Binding var text: String
  var onBackPressed: () -> ()

  func makeCoordinator() -> Coordinator {
    return Coordinator(text: $text)
  }

  func makeUIView(context: Context) -> CustomTextField {
    let textField = CustomTextField()
    textField.delegate = context.coordinator
    textField.onBackPressed = onBackPressed
    // Optionals
    textField.placeholder = hint
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .words
    textField.backgroundColor = .clear
    textField.addTarget(context.coordinator, action: #selector(Coordinator.textChange(textField:)), for: .editingChanged)
    return textField
  }

  func updateUIView(_ uiView: CustomTextField, context: Context) {
    uiView.text = text
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: CustomTextField, context: Context) -> CGSize? {
    return uiView.intrinsicContentSize
  }

  class Coordinator: NSObject, UITextFieldDelegate {
    @Binding var text: String
    init(text: Binding<String>) {
      self._text = text
    }

    // Text Change
    @objc
    func textChange(textField: UITextField) {
      text = textField.text ?? ""
    }

    // Closing on Pressing Return Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
    }
  }
}

fileprivate class CustomTextField: UITextField {
  open var onBackPressed: (() -> ())?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func deleteBackward() {
    // This will be called when ever keyboard back button is pressed
    onBackPressed?()
    super.deleteBackward()
  }

  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
}

struct TagField_Previews: PreviewProvider {
  static var previews: some View {
    TagTextFieldContentView()
  }
}
