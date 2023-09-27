//
//  HeartAnimation.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/27.
//
//  https://youtu.be/kZKI-BImtLE?si=rg-pvGKT5TG6mLQ9

import SwiftUI

struct HomeView: View {

  @State private var beatAnimation: Bool = false
  @State private var showPulses: Bool = false
  @State private var pulsedHearts: [HeartParticle] = []
  @State private var heartBeat: Int = 85

  var body: some View {
    VStack {
      ZStack {
        if showPulses {
          TimelineView(
            .animation(
              minimumInterval: 0.7,
              paused: false
            )
          ) { timeline in
            Canvas { context, size in
              // Draw into the Canvas
              for heart in pulsedHearts {
                if let resolvedView = context.resolveSymbol(id: heart.id) {
                  let centerX = size.width / 2
                  let centerY = size.height / 2

                  context.draw(resolvedView, at: CGPoint(x: centerX, y: centerY))
                }
              }

            } symbols: {
              // Insert into Canvas with Unique ID
              ForEach(pulsedHearts) {
                PulsedHeartView()
                  .id($0.id)
              }

            }
            .onChange(of: timeline.date) { oldValue, newValue in
              if beatAnimation {
                addPulsedHeart()
              }
            }
          }
        }

        Image(systemName: "suit.heart.fill")
          .font(.system(size: 100))
          .foregroundStyle(.pink.gradient)
          .symbolEffect(
            .bounce,
            options: !beatAnimation ? .default : .repeating.speed(1),
            value: beatAnimation
          )
      }
      .frame(maxWidth: 350, maxHeight: 350)
      .overlay(alignment: .bottomLeading) {
        VStack(alignment: .leading, spacing: 5) {
          Text("Current")
            .font(.title3.bold())
            .foregroundStyle(.black)

          HStack(alignment: .bottom, spacing: 6) {
            TimelineView(.animation(minimumInterval: 1.5, paused: false)) { timeline in
              Text("\(heartBeat)")
                .font(.system(size: 45).bold())
                .contentTransition(.numericText(value: Double(heartBeat)))
                .foregroundStyle(.black)
                .onChange(of: timeline.date) { oldValue, newValue in
                  if beatAnimation {
                    withAnimation(.bouncy) {
                      heartBeat = .random(in: 80...130)
                    }
                  }
                }
            }

            Text("BPM")
              .font(.callout.bold())
              .foregroundStyle(.pink.gradient)
          }

          Text("88 BPM, 10m ago")
            .font(.callout)
            .foregroundStyle(.gray)
        }
        .offset(x: 30, y: -35)
      }
      .background(.bar, in: .rect(cornerRadius: 30))

      Toggle("Beat Animation", isOn: $beatAnimation)
        .padding(15)
        .frame(maxWidth: 350)
        .background(.bar, in: .rect(cornerRadius: 15))
        .padding(.top, 20)
        .onChange(of: beatAnimation) { oldValue, newValue in
          if pulsedHearts.isEmpty {
            showPulses = true
          }

          if newValue && pulsedHearts.isEmpty {
            addPulsedHeart()
          }
        }
        .disabled(!beatAnimation && !pulsedHearts.isEmpty)
    }
  }

  func addPulsedHeart() {
    let pulsedHeart = HeartParticle()
    pulsedHearts.append(pulsedHeart)

    // Removing After the pulse animation was Finished
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      pulsedHearts.removeAll(where: { $0.id == pulsedHeart.id})

      if pulsedHearts.isEmpty {
        showPulses = false
      }
    }
  }
}

// Pulsed Heart Animation View
struct PulsedHeartView: View {
  @State private var startAnimation: Bool = false

  var body: some View {
    Image(systemName: "suit.heart.fill")
      .font(.system(size: 100))
      .foregroundStyle(.pink)
      .background(content: {
        Image(systemName: "suit.heart.fill")
          .font(.system(size: 100))
          .foregroundStyle(.black)
          .blur(radius: 5, opaque: false)
          .scaleEffect(startAnimation ? 1.1 : 0)
          .animation(.linear(duration: 1.5), value: startAnimation)
      })
      .scaleEffect(startAnimation ? 4 : 1)
      .opacity(startAnimation ? 0 : 0.7)
      .onAppear(perform: {
        withAnimation(.linear(duration: 3)) {
          startAnimation = true
        }
      })
  }
}

#Preview {
  HomeView()
}

struct HeartParticle: Identifiable {
  var id: UUID = .init()
}
