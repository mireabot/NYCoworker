//
//  HomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import Shimmer
import MapKit
import PopupView

struct HomeView: View {
  @State var isLoading = true
  @State var showMap = false
  @State var showFavorites = false
  @State var showNotifications = false
  @StateObject var locationManager = LocationManager()
  @StateObject private var locationService = LocationService()
  @EnvironmentObject var userService : UserService
  @AppStorage("UserID") var userId : String = ""
  @State var addToFavs = false
  var body: some View {
    NavigationStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 0) {
          /// Map section
          mapView()
          /// Locations section
          VStack(alignment: .leading, spacing: 15) {
            /// Category scrollview
            locationLibrariesCollection()
            
            /// Category scrollview
            locationLobbiesCollection()
            
            /// Category scrollview
            locationPublicSpacesCollection()
          }
        }
      }
      .popup(isPresented: $addToFavs) {
        NYCAlertNotificationView(alertStyle: .addedToFavorites)
      } customize: {
        $0
          .isOpaque(true)
          .autohideIn(1.5)
          .type(.floater())
          .position(.top)
          .animation(.spring(response: 0.4, blendDuration: 0.2))
      }
      .navigationDestination(for: Locations.self, destination: { locationType in
        LocationListView(type: locationType).environmentObject(locationService)
      })
      .navigationDestination(for: Location.self, destination: { locationData in
        LocationDetailView(locationData: locationData)
      })
      .navigationDestination(isPresented: $showFavorites, destination: {
        FavoriteView().environmentObject(userService)
      })
      .navigationDestination(isPresented: $showNotifications, destination: {
        NotificationsView()
      })
      .task {
        guard locationService.locations.isEmpty else { return }
        await locationService.fetchLoactions(completion: {
          Resources.userLocation = locationManager.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
          isLoading = false
        }) { err in
          locationService.setError(err)
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Image("appLogo")
            .resizable()
            .frame(width: 44, height: 44)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          NYCCircleImageButton(size: 20, image: Image("rate")) {showFavorites.toggle()}
        }
        
        ToolbarItem(placement: .primaryAction) {
          NYCCircleImageButton(size: 20, image: Image("bell")) {showNotifications.toggle()}
        }
      }
      .fullScreenCover(isPresented: $showMap, content: {
        LocationsMap().environmentObject(locationService)
      })
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.white, for: .navigationBar, .automatic)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}


extension HomeView {
  @ViewBuilder
  func locationLibrariesCollection() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      NavigationLink(
        value: Locations.libraries,
        label: {
          NYCSectionHeader(title: Locations.libraries.headerTitle, isExpandButton: true)
        })
      .padding(.leading, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 10) {
          if isLoading {
            ForEach(0..<4) { _ in
              LoadingLocationCell()
                .redacted(reason: .placeholder)
                .shimmering(active: true, duration: 1.5, bounce: false)
            }
          }
          else {
            ForEach(locationService.locations,id: \.locationName) { data in
              if data.locationType == .library {
                NavigationLink(value: data) {
                  LocationCell(data: data, type: .small, buttonAction: {
                    addLocationTofavs(location: data.locationID)
                  })
                }
              }
            }
          }
        }
        .padding([.leading,.trailing], 20)
      }
    }
  }
  
  @ViewBuilder
  func locationLobbiesCollection() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      NavigationLink(
        value: Locations.lobbies,
        label: {
          NYCSectionHeader(title: Locations.lobbies.headerTitle, isExpandButton: true)
        })
      .padding(.leading, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 10) {
          if isLoading {
            ForEach(0..<4) { _ in
              LoadingLocationCell()
                .redacted(reason: .placeholder)
                .shimmering(active: true, duration: 1.5, bounce: false)
            }
          }
          else {
            ForEach(locationService.locations,id: \.locationName) { data in
              if data.locationType == .hotel {
                NavigationLink(value: data) {
                  LocationCell(data: data, type: .large, buttonAction: {
                    addLocationTofavs(location: data.locationID)
                  })
                }
              }
            }
          }
        }
        .padding([.leading,.trailing], 20)
      }
    }
  }
  
  @ViewBuilder
  func locationPublicSpacesCollection() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      NavigationLink(
        value: Locations.publicSpaces,
        label: {
          NYCSectionHeader(title: Locations.publicSpaces.headerTitle, isExpandButton: true)
        })
      .padding(.leading, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 10) {
          if isLoading {
            ForEach(0..<4) { _ in
              LoadingLocationCell()
                .redacted(reason: .placeholder)
                .shimmering(active: true, duration: 1.5, bounce: false)
            }
          }
          else {
            ForEach(locationService.locations,id: \.locationName) { data in
              if data.locationType == .publicSpace {
                NavigationLink(value: data) {
                  LocationCell(data: data, type: .large, buttonAction: {
                    addLocationTofavs(location: data.locationID)
                  })
                }
              }
            }
          }
        }
        .padding([.leading,.trailing], 20)
      }
    }
  }
  
  @ViewBuilder
  func mapView() -> some View {
    VStack(alignment: .leading, spacing: 15) {
      NYCSectionHeader(title: "Locations nearby", isExpandButton: false)
      ZStack {
        Map(coordinateRegion: .constant(Resources.mapRegion))
          .frame(width: UIScreen.main.bounds.width - 16, height: 100)
          .cornerRadius(10)
          .disabled(true)
        
        Button {
          showMap.toggle()
        } label: {
          Text("Open map")
        }
        .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
        .padding([.leading,.trailing], 90)
      }
    }
    .padding()
  }
  
  func addLocationTofavs(location: String) {
    Task {
      await locationService.addFavoriteLocation(locationID: location, userID: userId, completion: {
        addToFavs.toggle()
      }) { err in
        locationService.setError(err)
      }
    }
  }
}
