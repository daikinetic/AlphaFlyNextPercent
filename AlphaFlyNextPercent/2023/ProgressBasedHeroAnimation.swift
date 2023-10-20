//
//  ProgressBasedHeroAnimation.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/10/15.
//
//  https://youtu.be/1h5NjJbheEU?si=EJSjO__6-Xp1bOm6

import SwiftUI

struct ProgressBasedHeroAnimation: View {
  var body: some View {
    HomeProgressBasedHero()
  }
}

#Preview {
  ProgressBasedHeroAnimation()
}

struct HomeProgressBasedHero: View {

  @State private var allProfiles: [Profile] = profiles
  @State private var selectedProfile: Profile?
  @State private var showDetail: Bool = false
  @State private var heroProgress: CGFloat = 0
  @State private var showHeroView: Bool = true

  var body: some View {
    NavigationStack {
      List(allProfiles) { profile in
        HStack(spacing: 12) {
          Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            .opacity(selectedProfile?.id == profile.id ? 0 : 1)
            .anchorPreference(key: AnchorKey.self, value: .bounds, transform: { anchor in
              return [profile.id.uuidString: anchor]
            })

          VStack(alignment: .leading, spacing: 6) {
            Text(profile.userName)
              .fontWeight(.semibold)

            Text(profile.lastMsg)
              .font(.caption2)
              .foregroundStyle(.gray)
          }
        }
        .contentShape(.rect)
        .onTapGesture {
          selectedProfile = profile
          showDetail = true

          withAnimation(.snappy(duration: 0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
            heroProgress = 1.0
          } completion: {
            Task {
              try? await Task.sleep(for: .seconds(0.1))
              showHeroView = false
            }
          }
        }
      }
      .navigationTitle("Progress Effect")
    }
    .overlay {
      DetailView(
        selectedProfile: $selectedProfile,
        heroProgress: $heroProgress,
        showDetail: $showDetail,
        showHeroView: $showHeroView
      )
    }
    // Hero Animation Layer
    .overlayPreferenceValue(AnchorKey.self, { value in
      GeometryReader { geometry in
        //Let's check whether we have both source and destination frames
        if let selectedProfile,
            let source = value[selectedProfile.id.uuidString],
           let destination = value["DESTINATION"] {

          let sourceRect = geometry[source]
          let radius = sourceRect.height / 2
          let destinationRect = geometry[destination]

          let diffSize = CGSize(
            width: destinationRect.width - sourceRect.width,
            height: destinationRect.height - sourceRect.height
          )

          let diffOrigin = CGPoint(
            x: destinationRect.minX - sourceRect.minX,
            y: destinationRect.minY - sourceRect.minY
          )

          ///Your Hero View
          ///Mine is just a profile image
          Image(selectedProfile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(
              width: sourceRect.width + (diffSize.width * heroProgress),
              height: sourceRect.height + (diffSize.height * heroProgress)
            )
            .clipShape(.rect(cornerRadius: radius))
            .offset(
              x: sourceRect.minX + (diffOrigin.x * heroProgress),
              y: sourceRect.minY + (diffOrigin.y * heroProgress)
            )
            .opacity(showHeroView ? 1 : 0)
        }

      }
    })
  }
}

struct DetailView: View {

  @Binding var selectedProfile: Profile?
  @Binding var heroProgress: CGFloat
  @Binding var showDetail: Bool
  @Binding var showHeroView: Bool
  @Environment(\.colorScheme) private var scheme
  @GestureState private var isDragging: Bool = false
  @State private var offset: CGFloat = .zero

  var body: some View {
    if let selectedProfile, showDetail {
      GeometryReader {
        let size = $0.size

        ScrollView {

          Rectangle()
            .fill(.clear)
            .overlay {
              if !showHeroView {
                Image(selectedProfile.profilePicture)
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: size.width, height: 400)
                  .clipShape(.rect(cornerRadius: 25))
                  .transition(.identity)
              }
            }
            .frame(height: 400)
          // Destination Anchor Frame
            .anchorPreference(key: AnchorKey.self, value: .bounds, transform: { anchor in
              return ["DESTINATION": anchor]
            })
            .visualEffect { content, geometryProxy in
              content
                .offset(y: geometryProxy.frame(in: .scrollView).minY > 0 ? -geometryProxy.frame(in: .scrollView).minY : 0 )
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
        .frame(width: size.width, height: size.height)
        .background {
          Rectangle()
            .fill(scheme == .dark ? .black : .white)
            .ignoresSafeArea()
        }
        // Close
        .overlay(alignment: .topLeading) {
          Button() {
            showHeroView = true
            withAnimation(.snappy(duration: 0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
              heroProgress = 0.0
            } completion: {
              showDetail = false
              self.selectedProfile = nil
            }
          } label: {
            Image(systemName: "xmark.circle.fill")
              .font(.largeTitle)
              .imageScale(.medium)
              .contentShape(.rect)
              .foregroundStyle(.white, .black)
          }
          .buttonStyle(.plain)
          .padding()
          .opacity(showHeroView ? 0 : 1)
          .animation(.snappy(duration: 0.2, extraBounce: 0), value: showHeroView)
        }
        .offset(x: size.width - (size.width * heroProgress))
        .overlay(alignment: .leading) {
          Rectangle()
            .fill(.clear)
            .frame(width: 10)
            .contentShape(.rect)
            .gesture(
              DragGesture()
                .updating($isDragging, body: { _, out, _ in
                  out = true
                })
                .onChanged({ value in
                  var translation = value.translation.width
                  translation = isDragging ? translation : .zero
                  translation = translation > 0 ? translation : 0
                  // Convert into Progress
                  let dragProgress = 1.0 - (translation / size.width)
                  // Limit Progress 0 - 1
                  let cappedProgres = min(max(0, dragProgress), 1)
                  heroProgress = cappedProgres
                  offset = translation
                  if !showHeroView {
                    showHeroView = true
                  }
                })
                .onEnded({ value in
                  // close/reset based on end target
                  let velocity = value.velocity.width
                  
                  if (offset + velocity) > (size.width * 0.8) {
                    //close view
                    withAnimation(.snappy(duration:0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
                      heroProgress = .zero
                    } completion: {
                      offset = .zero
                      showDetail = false
                      showHeroView = true
                      self.selectedProfile = nil
                    }
                  } else {
                    //reset
                    withAnimation(.snappy(duration:0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
                      heroProgress = 1.0
                      offset = .zero
                    } completion: {
                      showHeroView = false
                    }
                  }
                })
            )
        }
      }
    }
  }
}

struct Profile: Identifiable {
  var id = UUID()
  var userName: String
  var profilePicture: String
  var lastMsg: String
}

var profiles = [
  Profile(userName: "Justine", profilePicture: "pic", lastMsg: "Hello, World"),
  Profile(userName: "Justine", profilePicture: "mountain", lastMsg: "Hello, World"),
  Profile(userName: "Justine", profilePicture: "pic", lastMsg: "Hello, World"),
  Profile(userName: "Justine", profilePicture: "mountain", lastMsg: "Hello, World"),
  Profile(userName: "Justine", profilePicture: "pic", lastMsg: "Hello, World")
]

struct AnchorKey: PreferenceKey {
  static var defaultValue: [String: Anchor<CGRect>] = [:]
  static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
    value.merge(nextValue()) { $1 }
  }
}
