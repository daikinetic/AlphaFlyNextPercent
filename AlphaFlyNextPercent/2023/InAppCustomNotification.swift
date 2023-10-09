//
//  InAppCustomNotification.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/08.
//
//  https://youtu.be/MPp7b9bIUPY?si=4GIeLi_MTtCTtvZ0

import SwiftUI

struct InAppCustomNotification: View {
  @State private var showSheet: Bool = false

  var body: some View {
    NavigationStack {
      VStack {
        Button("Show Sheet") {
          showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
          Button("Show AirDrop Notification") {
            UIApplication.shared.inAppNotification(adaptForDynamicIsland: false, timeout: 3, swipeToClose: true) {

              HStack {
                Image(systemName: "wifi")
                  .font(.system(size: 40))
                  .foregroundStyle(.white)

                VStack(alignment: .leading, spacing: 2) {
                  Text("AirDrop")
                    .font(.caption.bold())
                    .foregroundStyle(.white)

                  Text("From Justine")
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                }
                .padding(.top, 20)

                Spacer(minLength: 0)
              }
              .padding(15)
              .background {
                RoundedRectangle(cornerRadius: 15)
                  .fill(.black)
              }
            }
          }
        }

        Button("Show Notification") {
          UIApplication.shared.inAppNotification(adaptForDynamicIsland: true, timeout: 3, swipeToClose: true) {

            HStack {
              Image("pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(.circle)

              VStack(alignment: .leading, spacing: 6) {
                Text("Justine")
                  .font(.caption.bold())
                  .foregroundStyle(.white)

                Text("Hello, This is Justine")
                  .textScale(.secondary)
                  .foregroundStyle(.gray)
              }
              .padding(.top, 20)

              Spacer(minLength: 0)

              Button {

              } label: {
                Image(systemName: "speaker.slash.fill")
                  .font(.title2)
              }
              .buttonStyle(.bordered)
              .buttonBorderShape(.circle)
              .tint(.white)
            }
            .padding(15)
            .background {
              RoundedRectangle(cornerRadius: 15)
                .fill(.black)
            }
          }
        }
      }
      .navigationTitle("In App Notification's")
    }
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
      if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag == 0320 }) {

        // Frame and SafeArea Values
        let frame = activeWindow.frame
        let safeArea = activeWindow.safeAreaInsets

        var tag: Int = 1009
        let checkForDynamicIsland = adaptForDynamicIsland && safeArea.top >= 51

        if let previousTag = UserDefaults.standard.value(forKey: "inAppNotificationTag") as? Int {
          tag = previousTag + 1
        }

        UserDefaults.standard.setValue(tag, forKey: "inAppNotificationTag")

        // Change Status into Black to blend with Dynamic Island
        if checkForDynamicIsland {
          if let controller = activeWindow.rootViewController as? StatusBarBasedController {

            controller.statusBarStyle = .darkContent
            controller.setNeedsStatusBarAppearanceUpdate()
          }
        }

        // Create UIView from SwiftUIView using UIHosting Configuration
        let config = UIHostingConfiguration {
          AnimatedNotificationView(
            content: content(),
            safeArea: safeArea,
            tag: tag,
            adaptForDynamicIsland: checkForDynamicIsland,
            timeout: timeout,
            swipeToClose: swipeToClose
          )
          .frame(width: frame.width - (checkForDynamicIsland ? 20 : 30), height: 120, alignment: .top)
          .contentShape(.rect)
        }

        let view = config.makeContentView()
        view.tag = tag
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false

        if let rootView = activeWindow.rootViewController?.view {

          rootView.addSubview(view)

          view.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
          view.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: -((frame.height - safeArea.top) / 2) + (checkForDynamicIsland ? 11 : safeArea.top)).isActive = true
        }
      }
    }
}

fileprivate struct AnimatedNotificationView<Content: View>: View {
  var content: Content
  var safeArea: UIEdgeInsets
  var tag: Int
  var adaptForDynamicIsland: Bool
  var timeout: CGFloat
  var swipeToClose: Bool
  @State private var animateNotification: Bool = false

  var body: some View {
    content
      .blur(radius: animateNotification ? 0 : 10)
      .disabled(!animateNotification)
      .mask {
        if adaptForDynamicIsland {
          GeometryReader { geometry in
            let size = geometry.size
            let radius = size.height / 2

            RoundedRectangle(cornerRadius: radius, style: .continuous)
          }
        } else {
          Rectangle()
        }
      }
      .scaleEffect(adaptForDynamicIsland ? (animateNotification ? 1 : 0.01) : 1, anchor: .init(x: 0.5, y: 0.01))
      .offset(y: offsetY)
      .gesture(
        DragGesture()
          .onEnded({ value in
            if -value.translation.height > 50 && swipeToClose {
              withAnimation(.smooth, completionCriteria: .logicallyComplete) {
                animateNotification = false
              } completion: {
                removeNotificationViewFromWindow()
              }
            }
          })
      )
      .onAppear {
        Task {
          guard !animateNotification else { return }
          withAnimation(.smooth) {
            animateNotification = true
          }

          try await Task.sleep(for: .seconds(timeout < 1 ? 1 : timeout))

          guard animateNotification else { return }

          withAnimation(.smooth, completionCriteria: .logicallyComplete) {
            animateNotification = false
          } completion: {
            removeNotificationViewFromWindow()
          }
        }
      }
  }

  var offsetY: CGFloat {
    if adaptForDynamicIsland {
      return 0
    }

    return animateNotification ? 10 : -(safeArea.top + 130)
  }

  func removeNotificationViewFromWindow() {
    if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag == 0320 }) {
      if let view = activeWindow.viewWithTag(tag) {
//        print("Removed view with \(tag)")
        view.removeFromSuperview()

        // Reset Once All the notifications was removed
        if let controller = activeWindow.rootViewController as? StatusBarBasedController, controller.view.subviews.isEmpty {

          controller.statusBarStyle = .default
          controller.setNeedsStatusBarAppearanceUpdate()
        }
      }
    }
  }
}

@main
struct InAppNotificationApp: App {
  @State private var overlayWindow: PassThroughWindow?

  var body: some Scene {
    WindowGroup {
      InAppCustomNotification()
        .onAppear {
          if overlayWindow == nil {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {

              let overlayWindow = PassThroughWindow(windowScene: windowScene)
              overlayWindow.backgroundColor = .clear
              overlayWindow.tag = 0320
              let controller = StatusBarBasedController()
              controller.view.backgroundColor = .clear
              overlayWindow.rootViewController = controller
              overlayWindow.isHidden = false
              overlayWindow.isUserInteractionEnabled = true
              self.overlayWindow = overlayWindow
//              print("Overlay Window Created")

            }
          }
        }
    }
  }
}

class StatusBarBasedController: UIViewController {
  var statusBarStyle: UIStatusBarStyle = .default

  override var preferredStatusBarStyle: UIStatusBarStyle {
    statusBarStyle
  }
}


fileprivate class PassThroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard let view = super.hitTest(point, with: event) else { return nil }
    return rootViewController?.view == view ? nil : view
  }
}
