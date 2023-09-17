//
//  Home.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/18.
//

import SwiftUI

struct Home: View {
  //MARK: - Properties
  @State private var tags: [Tag] = []

  var body: some View {
    NavigationStack {
      ScrollView(.vertical) {
        VStack {
          TagField(tags: $tags)
        }
        .padding()
      }
      .navigationTitle("Tag Field")
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
