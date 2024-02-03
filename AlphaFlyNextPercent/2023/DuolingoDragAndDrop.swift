//
//  DuolingoDragAndDrop.swift
//  
//
//  Created by Daiki Takano on 2024/01/28.
//
//  https://youtu.be/owo6Xtvad4c?si=MOHQ-mrW8dBG1APc
//
//  2024 1/28 3:05
//  2024 1/28 7:05
//  2024 1/29 8:45

import SwiftUI

@main
struct DuolingoDragAndDropApp: App {
  var body: some Scene {
    WindowGroup {
      DuolingoDragAndDrop()
    }
  }
}

fileprivate struct DuolingoDragAndDrop: View {

  @State var progress: CGFloat = 0
  @State var characters: [Character] = characters_
  //MARK: Custom Grid Arrays
  ///For Drag Part
  @State var shuffledRows: [[Character]] = []
  ///For Drop Part
  @State var rows: [[Character]] = []
  ///ANIMATION
  @State var isAnimatedWrongText: Bool = false
  @State var droppedCount: CGFloat = 0

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

      //MARK: Drag Drop Area
      DropArea()
        .padding(.vertical, 30)
      DragArea()
    }
    .padding()
    .onAppear {
      if rows.isEmpty {
        /// Creating Shuffled One -> Normal One
        characters = characters.shuffled()
        shuffledRows = generateGrid()
        characters = characters_
        rows = generateGrid()
      }
    }
    .offset(x: isAnimatedWrongText ? -30 : 0)
  }

  @ViewBuilder
  func DropArea() -> some View {
    VStack(spacing: 12) {
      ForEach($rows, id: \.self) { $row in
        HStack(spacing: 10) {
          ForEach($row) { $item in
            Text(item.value)
              .font(.system(size: item.fontSize))
              .padding(.vertical, 5)
              .padding(.horizontal, item.padding)
              .opacity(item.isShowing ? 1 : 0)
              .background {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                  .fill(item.isShowing ? .clear : .gray.opacity(0.25))
              }
              .background {
                /// IF ITEM IS DROPPED INTO CORRECT PLACE
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                  .stroke(.gray)
                  .opacity(item.isShowing ? 1 : 0)
              }
              /// ADDING DROP OPERATION
              .onDrop(of: [.url], isTargeted: .constant(false)) { providers in
                if let first = providers.first {
                  let _ = first.loadObject(ofClass: URL.self) { value, error in
                    guard let url = value else { return }
                    if item.id == "\(url)" {
                      droppedCount += 1
                      let progress = (droppedCount / CGFloat(characters.count))

                      withAnimation {
                        item.isShowing = true
                        updateShuffledArray(character: item)
                        self.progress = progress
                      }
                    } else {
                      /// ANIMATING WHEN WRONG TEXT DROPPED
                      animateView()
                    }

                  }
                }

                return false
              }
          }
        }

        if row != rows.last {
          Divider()
        }
      }
    }
  }

  @ViewBuilder
  func DragArea() -> some View {
    VStack(spacing: 12) {
      ForEach(shuffledRows, id: \.self) { row in
        HStack(spacing: 10) {
          ForEach(row) { item in
            Text(item.value)
              .font(.system(size: item.fontSize))
              .padding(.vertical, 5)
              .padding(.horizontal, item.padding)
              .background {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                  .stroke(.gray)
              }
              /// ADDING DRAG OPERATION
              .onDrag {
                /// RETURNING ID TO FIND WHICH ITEM IS MOVING
                return .init(contentsOf: URL(string: item.id))!
              }
              .opacity(item.isShowing ? 0 : 1)
              .background {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                  .fill(item.isShowing ? .gray.opacity(0.25) : .clear)
              }
          }
        }

        if row != shuffledRows.last {
          Divider()
        }
      }
    }
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

  func generateGrid() -> [[Character]] {

    /// Identifying Each Text Width and Updating it into State Variable
    for item in characters.enumerated() {
      let textSize = textSize(character: item.element)

      characters[item.offset].textSize = textSize
    }

    var gridArray: [[Character]] = []
    var tempArray: [Character] = []

    /// Current Width
    var currentWidth: CGFloat = 0
    /// -30 -> Horizontal Padding
    let totalScreenWidth: CGFloat = UIScreen.main.bounds.width - 30

    for character in characters {
      currentWidth += character.textSize

      if currentWidth < totalScreenWidth {
        tempArray.append(character)

      } else {
        gridArray.append(tempArray)
        tempArray = []
        currentWidth = character.textSize
        tempArray.append(character)
      }
    }

    /// Checking Exhaust
    if !tempArray.isEmpty {
      gridArray.append(tempArray)
    }

    return gridArray
  }

  ///Identifying Text Size
  func textSize(character: Character) -> CGFloat {
    let font = UIFont.systemFont(ofSize: character.fontSize)

    let attributes = [NSAttributedString.Key.font : font]

    let size = (character.value as NSString).size(
      withAttributes: attributes
    )

    /// Horizontal Padding
    return size.width + (character.padding * 2) + 10
  }

  func updateShuffledArray(character: Character) {
    for index in shuffledRows.indices {
      for subIndex in shuffledRows[index].indices {
        if shuffledRows[index][subIndex].id == character.id {
          shuffledRows[index][subIndex].isShowing = true
        }
      }
    }
  }

  func animateView() {
    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)) {
      isAnimatedWrongText = true
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)) {
        isAnimatedWrongText = false
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

fileprivate struct Character: Identifiable, Hashable, Equatable {
  var id = UUID().uuidString
  var value: String
  var padding: CGFloat = 10
  var textSize: CGFloat = .zero
  var fontSize: CGFloat = 19
  var isShowing: Bool = false
}

fileprivate var characters_: [Character] = [
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
