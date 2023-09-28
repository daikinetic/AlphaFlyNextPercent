//
//  HalfModal.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/28.
//
//  https://x.com/FloWritesCode/status/1706951555541299261?s=20

import SwiftUI

struct HalfModal: View {

  @State private var showSheet: Bool = false

  var body: some View {
    Button("Toggle Sheet") {
      showSheet.toggle()
    }
    .sheet(isPresented: $showSheet) {
      Text("Hello, World!")
        .presentationDetents([.large, .medium, .fraction(0.75)])
    }
  }
}

#Preview {
  HalfModal()
}
