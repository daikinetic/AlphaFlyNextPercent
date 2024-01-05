//
//  MapKitTrain.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/01/01.
//
//  MapKit

import Foundation
import SwiftUI
import MapKit

fileprivate struct Home: View {
  var body: some View {
    Text("Hello, world")
  }
}

#Preview {
  Home()
}

extension CLLocationCoordinate2D {
  static var myLocation: CLLocationCoordinate2D {
    return .init(latitude: 37.3346, longitude: -122.0090)
  }
}

extension MKCoordinateRegion {
  static var myRegion: MKCoordinateRegion {
    return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
  }
}
