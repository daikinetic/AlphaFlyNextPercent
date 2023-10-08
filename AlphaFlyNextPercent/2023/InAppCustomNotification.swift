//
//  InAppCustomNotification.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/08.
//
//  https://youtu.be/MPp7b9bIUPY?si=4GIeLi_MTtCTtvZ0

import SwiftUI

struct InAppCustomNotification: View {
  var body: some View {
    NavigationStack {
      VStack {
        Button("Show Notification") {
          UIApplication.shared.inAppNotification(adaptForDynamicIsland: true, timeout: 5, swipeToClose: true) {

            Rectangle()
              .fill(.black)
          }
        }
      }
    }
    .navigationTitle("In App Notification's")
  }
}

#Preview {
  InAppCustomNotification()
}

extension UIApplication {
  func inAppNotification<Content: View>(
    adaptForDynamicIsland: Bool = false,
    timeout: CGFloat = 5,
    swipeToClose: Bool = true,
    @ViewBuilder content: @escaping () -> Content) {

      // Fetch Active Window via WindowScene
      if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) {

        // Frame and SafeArea Values
        let frame = activeWindow.frame
        let safeArea = activeWindow.safeAreaInsets

        // Create UIView from SwiftUIView using UIHosting Configuration
        let config = UIHostingConfiguration {
          AnimatedNotificationView(
          content: content(),
          adaptForDynamicIsland: adaptForDynamicIsland,
          timeout: timeout,
          swipeToClose: swipeToClose
        )
      }
    }
  }
}

fileprivate struct AnimatedNotificationView<Content: View>: View {
  var content: Content
  var adaptForDynamicIsland: Bool
  var timeout: CGFloat
  var swipeToClose: Bool

  var body: some View {
    content
  }
}
