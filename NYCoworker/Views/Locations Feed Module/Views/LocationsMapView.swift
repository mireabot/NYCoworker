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

struct LocationsMap: View {
  @EnvironmentObject var locationsService: LocationService
  @EnvironmentObject var navigationState: NavigationDestinations
  @State var selectedLocation: Location?
  @State var showAlert = false
  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottom) {
        LocationMapView(locations: locationsService.locations, selectedLocation: $selectedLocation, region: getRegion(), type: .mapModule)
          .ignoresSafeArea()
        
        ZStack {
          ForEach(locationsService.locations){ location in
            if selectedLocation == location {
              NavigationLink(destination: LocationDetailView(locationData: location)) {
                LocationMapCard(location: location) {
                  showAlert.toggle()
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing),removal: .move(edge: .leading)))
              }
            }
          }
        }.padding(.bottom, 30)
      }
      .navigationDestination(for: Location.self, destination: { locationData in
        LocationDetailView(locationData: locationData)
      })
      .popup(isPresented: $showAlert) {
        NYCAlertNotificationView(alertStyle: .addedToFavorites)
      } customize: {
        $0
          .isOpaque(true)
          .autohideIn(1.5)
          .type(.floater())
          .position(.top)
          .animation(.spring(response: 0.4, blendDuration: 0.2))
      }
      .toolbarBackground(.clear, for: .navigationBar)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.close, color: .black) {
            dismiss()
          }
        }
      }
    }
    .applyNavigationTransition()
    .navigationBarBackButtonHidden()
  }
  
  private func getRegion() -> MKCoordinateRegion {
    let center = CLLocationCoordinate2D(latitude: locationsService.locations.first?.locationCoordinates.latitude ?? 0.0, longitude: locationsService.locations.first?.locationCoordinates.longitude ?? 0.0)
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    return MKCoordinateRegion(center: center, span: span)
  }
  
  func dismiss() {
    navigationState.isPresentingMap = false
  }
}

struct LocationMapView: View {
  var locations: [Location]
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

extension LocationMapView { //MARK: - View components
  @ViewBuilder
  func homePreview() -> some View {
    Map(coordinateRegion: $region,
        interactionModes: .zoom, showsUserLocation: false, annotationItems: locations) { location in
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

extension LocationMapView { //MARK: - Functions
  func updateRegion(location: Location) {
    let center = CLLocationCoordinate2D(latitude: location.locationCoordinates.latitude, longitude: location.locationCoordinates.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    region = MKCoordinateRegion(center: center, span: span)
  }
}
