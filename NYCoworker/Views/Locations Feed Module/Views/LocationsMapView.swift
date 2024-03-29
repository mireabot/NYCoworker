//
//  LocationsMapView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import MapKit
import PopupView
import CoreLocation

struct LocationsMapView: View {
  @Environment(\.dismiss) var makeDismiss
  @EnvironmentObject var locationStore: LocationStore
  @State var currentLocation: Location?
  @State private var selectedLocation: Location?
  @State var locations: [Location] = []
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        NYCMap(locations: $locations, selectedLocation: $currentLocation, region: getRegion(), type: .mapModule)
          .ignoresSafeArea()
        
        ZStack {
          ForEach(locations, id: \.self) { location in
            if currentLocation == location {
              LocationMapCard(location: location)
                .transition(.slide)
                .onTapGesture {
                  selectedLocation = location
                }
            }
          }
        }
        .padding(.bottom, 30)
      }
      .onReceive(locationStore.$locations, perform: { data in
        self.locations = data
      })
      .fullScreenCover(item: $selectedLocation, content: { locationData in
        LocationDetailView(selectedLocation: locationData)
      })
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.clear, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.chevronDown) {
            makeDismiss()
          }
        }
      }
    }
  }
  
  private func getRegion() -> MKCoordinateRegion {
    let center = CLLocationCoordinate2D(latitude: locations.first?.locationCoordinates.latitude ?? 0.0, longitude: locations.first?.locationCoordinates.longitude ?? 0.0)
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    return MKCoordinateRegion(center: center, span: span)
  }
}

struct NYCMap: View {
  @Binding var locations: [Location]
  @Binding var selectedLocation: Location?
  @State var region: MKCoordinateRegion
  enum MapType {
    case homePreview
    case mapModule
  }
  var type: MapType
  var body: some View {
    switch type {
    case .homePreview:
      homePreview()
    case .mapModule:
      mapModule()
    }
  }
}

extension NYCMap { //MARK: - View components
  @ViewBuilder
  func homePreview() -> some View {
    Map(coordinateRegion: $region,
        interactionModes: .zoom, showsUserLocation: false, annotationItems: locations) { location in
      MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.locationCoordinates.latitude, longitude: location.locationCoordinates.longitude)) {
        Button(action: {
          withAnimation {
            DispatchQueue.main.async {
              selectedLocation = location
              updateRegion(location: location)
            }
          }
        }, label: {
          Image("mapPin")
            .resizable()
            .frame(width: 45, height: 45)
            .scaleEffect(selectedLocation == location ? 1 : 0.7)
        })
      }
    }
  }
  
  @ViewBuilder
  func mapModule() -> some View {
    Map(coordinateRegion: $region,
        showsUserLocation: true, annotationItems: locations) { location in
      MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.locationCoordinates.latitude, longitude: location.locationCoordinates.longitude)) {
        Button(action: {
          DispatchQueue.main.async {
            withAnimation(.easeOut) {
              selectedLocation = location
              updateRegion(location: location)
            }
          }
        }, label: {
          Image("mapPin")
            .resizable()
            .frame(width: 45, height: 45)
            .scaleEffect(selectedLocation == location ? 1 : 0.7)
        })
      }
    }
        .onAppear {
          selectedLocation = locations.first!
        }
  }
}

extension NYCMap { //MARK: - Functions
  func updateRegion(location: Location) {
    let center = CLLocationCoordinate2D(latitude: location.locationCoordinates.latitude, longitude: location.locationCoordinates.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    region = MKCoordinateRegion(center: center, span: span)
  }
}
