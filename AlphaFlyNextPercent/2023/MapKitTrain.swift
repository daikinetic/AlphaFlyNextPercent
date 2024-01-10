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
  @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
  @Namespace private var locationSpace
  @State private var searchText: String = ""
  @State private var showSearch: Bool = false
  @State private var searchResults: [MKMapItem] = []
  var body: some View {
    NavigationStack {
      Map(position: $cameraPosition, scope: locationSpace) {
        ///Map Annotations
        Annotation("Apple Park", coordinate: .myLocation) {
          ZStack {
            Image(systemName: "applelogo")
              .font(.title3)
            Image(systemName: "square")
              .font(.largeTitle)
          }
        }
        .annotationTitles(.hidden)

        ///Simply Display Annotations as Marker, as we seen before
        ForEach(searchResults, id: \.self) { mapItem in
          let placeMark = mapItem.placemark
          Marker(placeMark.name ?? "Place", coordinate: placeMark.coordinate)
        }

        ///To Show User Current Location
        UserAnnotation()
      }
      .overlay(alignment: .bottomTrailing) {
        VStack(spacing: 15) {
          MapCompass(scope: locationSpace)
          MapPitchToggle(scope: locationSpace)
          MapUserLocationButton(scope: locationSpace)
        }
        .buttonBorderShape(.circle)
        .padding()
      }
      .mapScope(locationSpace)
      .navigationTitle("Map")
      .navigationBarTitleDisplayMode(.inline)
      .searchable(text: $searchText, isPresented: $showSearch)
      .toolbarBackground(.visible, for: .navigationBar)
    }
    .onSubmit(of: .search) {
      Task {
        guard !searchText.isEmpty else { return }

        await searchPlaces()
      }
    }
  }

  func searchPlaces() async {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchText
    request.region = .myRegion

    let results = try? await MKLocalSearch(request: request).start()
    searchResults = results?.mapItems ?? []
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
