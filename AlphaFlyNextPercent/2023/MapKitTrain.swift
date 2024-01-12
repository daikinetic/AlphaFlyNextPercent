//
//  MapKitTrain.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/01/01.
//
//  MapKit
//  19min 1/12 Fri 14:10

import Foundation
import SwiftUI
import MapKit

fileprivate struct Home: View {
  @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
  @State private var mapSelection: MKMapItem?
  @Namespace private var locationSpace
  @State private var viewingRegion: MKCoordinateRegion?
  ///Search
  @State private var searchText: String = ""
  @State private var showSearch: Bool = false
  @State private var searchResults: [MKMapItem] = []
  ///MapSelection
  @State private var showDetails: Bool = false
  @State private var lookAroundScene: MKLookAroundScene?
  ///Route
  @State private var routeDisplaying: Bool = false
  @State private var route: MKRoute?
  @State private var routeDestination: MKMapItem?

  var body: some View {
    NavigationStack {
      Map(position: $cameraPosition, selection: $mapSelection, scope: locationSpace) {
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
          /// Hiding All other Markers, Expect Destination One
          if routeDisplaying {
            if mapItem == routeDestination {
              let placeMark = mapItem.placemark
              Marker(placeMark.name ?? "Place", coordinate: placeMark.coordinate)
                .tint(.blue)
            }
          } else {
            let placeMark = mapItem.placemark
            Marker(placeMark.name ?? "Place", coordinate: placeMark.coordinate)
              .tint(.blue)
          }
        }

        ///Display Route using Polyline
        if let route {
          MapPolyline(route.polyline)
            .stroke(.blue, lineWidth: 7)
        }

        ///To Show User Current Location
        UserAnnotation()
      }
      .onMapCameraChange({ ctx in
        viewingRegion = ctx.region
      })
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
      ///When Route Displaying Hiding Top and Bottom Bar
      .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
      .sheet(isPresented: $showDetails, content: {
        MapDetails()
          .presentationDetents([.height(300)])
          .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
          .presentationCornerRadius(25)
          .interactiveDismissDisabled(true)
      })
    }
    .onSubmit(of: .search) {
      Task {
        guard !searchText.isEmpty else { return }

        await searchPlaces()
      }
    }
    .onChange(of: showSearch, initial: false) {
      if !showSearch {
        ///Clearing Search Results
        searchResults.removeAll(keepingCapacity: false)
        showDetails = false
        ///Zooming out to User Region when Search Cancelled
        withAnimation(.snappy) {
          cameraPosition = .region(.myRegion)
        }
      }
    }
    .onChange(of: mapSelection) { oldValue, newValue in
      ///Displaying Details about the Selected Place
      showDetails = newValue != nil
      ///Fetching Look Around Preview, when ever selection Changes
      fetchLookAroundPreview()
    }
  }

  @ViewBuilder
  func MapDetails() -> some View {
    VStack(spacing: 15) {
      ZStack {
        if lookAroundScene == nil {
          ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
        } else {
          LookAroundPreview(scene: $lookAroundScene)
        }
      }
      .frame(height: 200)
      .clipShape(.rect(cornerRadius: 15))
      ///Close Button
      .overlay(alignment: .topTrailing) {
        Button(action: {
          ///Closing View
          showDetails = false
          withAnimation(.snappy) {
            mapSelection = nil
          }
        }, label: {
          Image(systemName: "xmark.circle.fill")
            .font(.title)
            .foregroundStyle(.black)
            .background(.white, in: .circle)
        })
        .padding(10)
      }

      Button("Get Directions", action: fetchRoute)
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 12)
      .background(.blue.gradient, in: .rect(cornerRadius: 15))
    }
    .padding(15)
  }

  func searchPlaces() async {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchText
    request.region = viewingRegion ?? .myRegion

    let results = try? await MKLocalSearch(request: request).start()
    searchResults = results?.mapItems ?? []
  }

  func fetchLookAroundPreview() {
    if let mapSelection {
      ///Clearing Old One
      lookAroundScene = nil
      Task {
        let request = MKLookAroundSceneRequest(mapItem: mapSelection)
        lookAroundScene = try? await request.scene
      }
    }
  }

  func fetchRoute() {
    if let mapSelection {
      let request = MKDirections.Request()
      request.source = .init(placemark: .init(coordinate: .myLocation))
      request.destination = mapSelection

      Task {
        let result = try? await MKDirections(request: request).calculate()
        route = result?.routes.first
        ///Saving Route Destination
        routeDestination = mapSelection

        withAnimation(.snappy) {
          routeDisplaying = true
          showDetails = false
        }
      }
    }

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
