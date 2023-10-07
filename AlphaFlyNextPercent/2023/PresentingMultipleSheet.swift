//
//  PresentingMultipleSheet.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/07.
//
//  https://twitter.com/azamsharp/status/1709902413484745142/photo/1

import SwiftUI

struct PresentingMultipleSheet: View {
  
  @State private var activeSheet: Sheets?

  // Ctl A / Ctl K

  var body: some View {
    VStack {
      Button("Present Add Movie View") {
        activeSheet = .addMovie
      }

      Button("Present Movie Detail View") {
        activeSheet = .movieDetails(Movie(id: 1, name: "Batman"))
      }
    }
    .sheet(item: $activeSheet) { activeSheet in
      switch activeSheet {
      case .addMovie:
        Text("addMovie")
      case .movieDetails(let movie):
        Text(movie.name)
      }
    }
    .padding()
  }
}

#Preview {
  PresentingMultipleSheet()
}

struct Movie {
  let id: Int
  let name: String
}

enum Sheets: Identifiable {

  case addMovie
  case movieDetails(Movie)

  var id: Int {
    switch self {
    case .addMovie:
      return 0

    case .movieDetails(let movie):
      return movie.id
    }
  }
}
