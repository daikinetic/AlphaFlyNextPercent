//
//  EmptyStateHandlingInIOS17.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/22.
//
//  https://medium.com/devtechie/empty-state-handling-in-ios-17-swiftui-5-2a27024a89e7
//  MARK: Needs XCode15 Update


import SwiftUI

struct EmptyStateHandlingInIOS17: View {
  var body: some View {
    if #available(iOS 17.0, *) {
      ContentUnavailableView(
        "This app is unavailable",
        systemImage: "magnifyingglass",
        description: Text("This app is unavailable as we are busy to create new feature for everyone")
          .italic()
      )
    } else {
      // Fallback on earlier versions
    }
  }
}

struct EmptyStateHandlingInIOS17Ver2: View {
  var body: some View {
    if #available(iOS 17.0, *) {
      ContentUnavailableView {
        Label("Sorry! No result found: (", systemImage: "magnifyingglass")
      } description: {
        Text("Try another keyword")
      } actions: {
        HStack {
          Button("Go back") {}
          Button(role: .destructive) {} label: {
            Text("Reset filters")
          }
        }
      }


    } else {
      // Fallback on earlier versions
    }
  }
}

@available(iOS 17.0, *)
struct EmptyStateHandlingInIOS17WithSearchView: View {

  let courses = [
    "Mastering SwiftUI", "Build TaskList using MVVM", "Mastering WidgetKit", "DiscoveryPlus Clone"
  ]
  @State private var searchText = ""

  var body: some View {
    NavigationStack {
      List {

        if searchResults.isEmpty {
          ContentUnavailableView.search(text: searchText)

        } else {
          ForEach(searchResults, id: \.self) { course in
            NavigationLink {
              Text(course)
            } label: {
              Text(course)
            }
          }
        }
      }
      .searchable(text: $searchText)
    }
  }

  var searchResults: [String] {
    if searchText.isEmpty {
      return courses
    } else {
      return courses.filter {
        $0.contains(searchText)
      }
    }
  }
}

@available(iOS 17.0, *)
struct EmptyStateHandlingInIOS17_Previews: PreviewProvider {
  static var previews: some View {
//    EmptyStateHandlingInIOS17()
//    EmptyStateHandlingInIOS17Ver2()
    EmptyStateHandlingInIOS17WithSearchView()
  }
}
