//
//  DarkModeAnimation.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/01.
//
//  https://youtu.be/4dbnfyXILc4?si=Dpl5kZd0-Moyxk-7

import SwiftUI



struct DarkModeAnimation: View {
  @State private var activeTab: Int = 0
  @State private var toggles: [Bool] = Array(repeating: false, count: 10)

  @AppStorage("toggleDarkMode") private var toggleDarkMode: Bool = false
  @AppStorage("activateDarkMode") private var activateDarkMode: Bool = false
  @State private var buttonRect: CGRect = .zero

  @State private var currentImage: UIImage?
  @State private var previousImage: UIImage?
  @State private var maskAnimation: Bool = false

  var body: some View {
    TabView(selection: $activeTab) {
      NavigationStack {
        List {
          Section("Text Section") {
            Toggle("Large Display", isOn: $toggles[0])
            Toggle("Bold Text", isOn: $toggles[1])
          }

          Section {
            Toggle("Night Light", isOn: $toggles[2])
            Toggle("True Tone", isOn: $toggles[3])
          } header: {
            Text("Display Section")
          } footer: {
            Text("This is a Sample Footer.")
          }
        }
        .navigationTitle("Dark Mode")
      }
      .tabItem {
        Image(systemName: "house")
        Text("Home")
      }

      Text("Settings")
        .tabItem {
          Image(systemName: "gearshape")
          Text("Settings")
        }
    }
    .createImages(
      toggleDarkMode: toggleDarkMode,
      currentImage: $currentImage,
      previousImage: $previousImage,
      activateDarkMode: $activateDarkMode
    )
    .overlay {
      GeometryReader { geometry in
        let size = geometry.size

        if let previousImage, let currentImage {
          ZStack {
            Image(uiImage: previousImage)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: size.width, height: size.height)

            Image(uiImage: currentImage)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: size.width, height: size.height)
              .mask(alignment: .topLeading) {
                Circle()
                  .frame(width: buttonRect.width * (maskAnimation ? 80 : 1), height: buttonRect.height * (maskAnimation ? 80 : 1), alignment: .bottomLeading)
                  .frame(width: buttonRect.width, height: buttonRect.height)
                  .offset(x: buttonRect.minX, y: buttonRect.minY)
                  .ignoresSafeArea()
              }
          }
          .task {
            guard !maskAnimation else { return }
            withAnimation(.easeInOut(duration: 0.9), completionCriteria: .logicallyComplete) {
              maskAnimation = true
            } completion: {
              self.currentImage = nil
              self.previousImage = nil
              maskAnimation = false
            }
          }
        }
      }
      .mask({
        Rectangle()
          .overlay(alignment: .topLeading) {
            Circle()
              .frame(width: buttonRect.width, height: buttonRect.height)
              .offset(x: buttonRect.minX, y: buttonRect.minY)
              .blendMode(.destinationOut)
          }
      })
    }
    .overlay(alignment: .topTrailing) {
      Button(action: { toggleDarkMode.toggle() }) {
        Image(systemName: toggleDarkMode ? "sun.max.fill" : "moon.fill")
          .font(.title2)
          .foregroundStyle(Color.primary)
          .symbolEffect(.bounce, value: toggleDarkMode)
          .frame(width: 40, height: 40)
      }
      .rect { rect in
        buttonRect = rect
      }
      .padding(10)
      .disabled(currentImage != nil || previousImage != nil || maskAnimation)
    }
    .preferredColorScheme(activateDarkMode ? .dark : .light)

  }
}

#Preview {
  DarkModeAnimation()
}

struct RectKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}

extension View {
  @ViewBuilder
  func rect(value: @escaping (CGRect) -> ()) -> some View {
    self
      .overlay {
        GeometryReader { geometry in
          let rect = geometry.frame(in: .global)

          Color.clear
            .preference(key: RectKey.self, value: rect)
            .onPreferenceChange(RectKey.self, perform: { rect in
              value(rect)
            })
        }
      }
  }

  @MainActor
  @ViewBuilder
  func createImages(toggleDarkMode: Bool, currentImage: Binding<UIImage?>, previousImage: Binding<UIImage?>, activateDarkMode: Binding<Bool>) -> some View {

    self
      .onChange(of: toggleDarkMode) { oldValue, newValue in
        Task {

          if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) {
            let imageView = UIImageView()
            imageView.frame = window.frame
            imageView.image = window.rootViewController?.view.image(window.frame.size)
            imageView.contentMode = .scaleAspectFit
            window.addSubview(imageView)

            if let rootView = window.rootViewController?.view {

              let frameSize = rootView.frame.size

              activateDarkMode.wrappedValue = !newValue
              previousImage.wrappedValue = rootView.image(frameSize)

              activateDarkMode.wrappedValue = newValue

              try await Task.sleep(for: .seconds(0.01))
              currentImage.wrappedValue = rootView.image(frameSize)

              try await Task.sleep(for: .seconds(0.01))
              imageView.removeFromSuperview()
            }
          }
        }
      }
  }
}

extension UIView {
  func image(_ size: CGSize) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { _ in
      drawHierarchy(in: .init(origin: .zero, size: size), afterScreenUpdates: true)
    }
  }
}
