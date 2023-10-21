//
//  DatePicker.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/21.
//
//  https://x.com/lococo85327937/status/1714256481544196272?s=20

import SwiftUI


struct DatePicker_: View {

  @State var birthdayDate: Date = .init()

  var body: some View {
    DatePicker(
      "Date",
      selection: $birthdayDate,
      in: ...Date(),
      displayedComponents: [.date]
    )
    .datePickerStyle(.wheel)
    .labelsHidden()
    .environment(\.locale, Locale(identifier: "ja_JP"))
    .presentationDetents([.medium])
  }
}

#Preview {
  DatePicker_()
}
