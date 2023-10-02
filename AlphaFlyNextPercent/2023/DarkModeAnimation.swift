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

  @State private var toggleDarkMode: Bool = false
  @State private var activateDarkMode: Bool = false
  @State private var buttonRect: CGRect = .zero

  @State private var currentImage: UIImage?
  @State private var previousImage: UIImage?

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
    .overlay(alignment: .topLeading) {
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
    }
    .overlay(alignment: .topLeading) {
      if buttonRect != .zero {
        Circle()
          .fill(.red)
          .frame(width: buttonRect.width, height: buttonRect.height)
          .offset(x: buttonRect.minX, y: buttonRect.minY)
          .ignoresSafeArea()
          .hidden()
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
          VStack {
            Image(uiImage: previousImage)
              .resizable()
              .aspectRatio(contentMode: .fit)

            Image(uiImage: currentImage)
              .resizable()
              .aspectRatio(contentMode: .fit)
          }
        }
      }
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
            if let rootView = window.rootViewController?.view {

              let frameSize = rootView.frame.size

              activateDarkMode.wrappedValue = !newValue
              previousImage.wrappedValue = rootView.image(frameSize)

              activateDarkMode.wrappedValue = newValue

              try await Task.sleep(for: .seconds(0.01))
              currentImage.wrappedValue = rootView.image(frameSize)
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
