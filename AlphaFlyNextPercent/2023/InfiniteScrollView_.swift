//
//  InfiniteScrollView_.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/01/18.
//
//  https://youtu.be/lyuo59840qs?si=xrxAbylysySkzXj2
//  2024 1/18 6:36

import SwiftUI

fileprivate struct InfiniteScrollView_: View {
  @State private var items: [Item] = [.red, .blue, .green, .yellow, .black].compactMap {
    return .init(color: $0)
  }

  var body: some View {
    NavigationStack {
      ScrollView(.vertical) {
        VStack {
          GeometryReader {
            let size = $0.size

            LoopingScrollView(width: size.width, spacing: 0, items: items) { item in
              RoundedRectangle(cornerRadius: 15)
                .fill(item.color.gradient)
                .padding(.horizontal, 15)
            }
            //.contentMargins(.horizontal, 15, for: .scrollContent)
            .scrollTargetBehavior(.paging)
          }
          .frame(height: 220)
        }
        .padding(.vertical, 15)
      }
      .scrollIndicators(.hidden)
      .navigationTitle("Looping ScrollView")
    }
  }
}

#Preview {
  InfiniteScrollView_()
}

fileprivate struct LoopingScrollView<
  Content: View, 
  Item: RandomAccessCollection
>: View where Item.Element: Identifiable
{
  var width: CGFloat
  var spacing: CGFloat = 0
  var items: Item
  @ViewBuilder var content: (Item.Element) -> Content

  var body: some View {
    GeometryReader {
      let size = $0.size
      let repeatingCount = (width > 0) ? Int((size.width / width).rounded()) + 1 : 1

      ScrollView(.horizontal) {
        LazyHStack(spacing: spacing) {
          ForEach(items) { item in
            content(item)
              .frame(width: width)
          }

          ForEach(0..<repeatingCount, id: \.self) { index in
            let item = Array(items)[index % items.count]
            content(item)
              .frame(width: width)
          }
        }
        .background {
          ScrollViewHelper(
            width: width,
            spacing: spacing,
            itemsCount: items.count,
            repeatingCount: repeatingCount
          )
        }
      }
    }
  }
}

fileprivate struct ScrollViewHelper: UIViewRepresentable {
  var width: CGFloat
  var spacing: CGFloat
  var itemsCount: Int
  var repeatingCount: Int

  func makeCoordinator() -> Coordinator {
    return Coordinator(
      width: width,
      spacing: spacing,
      itemsCount: itemsCount,
      repeatingCount: repeatingCount
    )
  }

  func makeUIView(context: Context) -> some UIView {
    return .init()
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
      if let scrollView = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isAdded {

        scrollView.delegate = context.coordinator
        context.coordinator.isAdded = true
      }
    }

    context.coordinator.width = width
    context.coordinator.spacing = spacing
    context.coordinator.itemsCount = itemsCount
    context.coordinator.repeatingCount = repeatingCount
  }

  class Coordinator: NSObject, UIScrollViewDelegate {
    var width: CGFloat
    var spacing: CGFloat
    var itemsCount: Int
    var repeatingCount: Int

    init(width: CGFloat, spacing: CGFloat, itemsCount: Int, repeatingCount: Int) {
      self.width = width
      self.spacing = spacing
      self.itemsCount = itemsCount
      self.repeatingCount = repeatingCount
    }

    ///Tells us whether the delegate is added or not
    var isAdded: Bool = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      guard itemsCount > 0 else { return }

      let minX = scrollView.contentOffset.x
      let mainContentSize = CGFloat(itemsCount) * width
      let spacingSize = CGFloat(itemsCount) * spacing

      if minX > (mainContentSize + spacingSize) {
        scrollView.contentOffset.x -= (mainContentSize + spacingSize)
      }

      if minX < 0 {
        scrollView.contentOffset.x += (mainContentSize + spacingSize)
      }
    }
  }

}

fileprivate struct Item: Identifiable {
  var id: UUID = .init()
  var color: Color
}
