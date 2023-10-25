//
//  trackingModifier_.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/25.
//
//  https://x.com/ios_dev_alb/status/1716739064290816315?s=20

import SwiftUI

struct trackingModifier_: View {
    var body: some View {
      VStack(spacing: 100) {
        Text("Developer")
          .font(.system(size: 42))
          .bold()
          .tracking(25)

        Text("Developer")
          .font(.system(size: 42))
          .bold()
          .kerning(25)
      }
    }
}

#Preview {
    trackingModifier_()
}
