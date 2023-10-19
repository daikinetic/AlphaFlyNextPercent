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

  var body: some View {
    NavigationStack {
      List(allProfiles) { profile in
        HStack(spacing: 12) {
          Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(.circle)
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
        }
      }
      .navigationTitle("Progress Effect")
    }
    .overlay {
      DetailView(
        selectedProfile: $selectedProfile,
        showDetail: $showDetail
      )
    }
    // Hero Animation Layer
    .overlayPreferenceValue(AnchorKey.self, { value in
      GeometryReader { geometry in
        //Let's check whether we have both source and destination frames
        if let selectedProfile, let source = value[selectedProfile.id.uuidString], let destination = value["DESTINATION"] {
          Color.red
        }

      }
    })
  }
}

struct DetailView: View {

  @Binding var selectedProfile: Profile?
  @Binding var showDetail: Bool
  @Environment(\.colorScheme) private var scheme

  var body: some View {
    if let selectedProfile, showDetail {
      GeometryReader {
        let size = $0.size

        ScrollView {

          Rectangle()
            .fill(.clear)
            .overlay {
              Image(selectedProfile.profilePicture)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: 400)
                .clipped()
                .hidden()
            }
            .frame(height: 400)
            // Destination Anchor Frame
            .anchorPreference(key: AnchorKey.self, value: .bounds, transform: { anchor in
              return ["DESTINATION": anchor]
            })
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
            showDetail = false
            self.selectedProfile = nil
          } label: {
            Image(systemName: "xmark.circle.fill")
              .font(.largeTitle)
              .imageScale(.medium)
              .contentShape(.rect)
              .foregroundStyle(.white, .black)
          }
          .buttonStyle(.plain)
          .padding()
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
