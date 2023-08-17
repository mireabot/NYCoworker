//
//  HomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import MapKit
import PopupView
import PostHog

struct HomeView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  @State var isLoading = true
  @StateObject var locationManager = LocationManager()
  @StateObject private var locationService = LocationService()
  @StateObject private var notificationService = NotificationService()
  @AppStorage("UserID") var userId : String = ""
  @State var addToFavs = false
  var publicSpacesLocations: [Location] { return locationService.locations.filter({ $0.locationType == .publicSpace}) }
  var librariesLocations: [Location] { return locationService.locations.filter( { $0.locationType == .library }) }
  var hotelsLocations: [Location] { return locationService.locations.filter( { $0.locationType == .hotel }) }
  var cafesLocations: [Location] { return locationService.locations.filter( { $0.locationType == .cafe }) }
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 0) {
          /// Map section
          mapView().padding(.top, 5)
          /// Locations section
          VStack(alignment: .leading, spacing: 20) {
            /// Category scrollview
            locationLobbiesCollection()
            
            if isLoading {
              PromoBannerLoadingView()
            }
            else {
              NYCPromoBanner(bannerType: .summerLocations) {
                DispatchQueue.main.async {
                  router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.cafe.headerTitle, selectedLocations: cafesLocations)))
                }
              }
            }
            
            /// Category scrollview
            locationPublicSpacesCollection()
            
            /// Category scrollview
            locationLibrariesCollection()
          }
          .padding([.top,.bottom], 10)
        }
      }
      .refreshable(action: {
        DispatchQueue.main.async {
          isLoading = true
        }
        await locationService.fetchLocations(completion: {
          Resources.userLocation = locationManager.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
          print("Locations are loaded \(locationService.locations.count)")
          isLoading = false
        }) { err in
          locationService.setError(err)
        }
      })
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
      .task {
        guard locationService.locations.isEmpty else { return }
        await locationService.fetchLocations(completion: {
          Resources.userLocation = locationManager.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
          print("Locations are loaded \(locationService.locations.count)")
          isLoading = false
        }) { err in
          locationService.setError(err)
        }
        guard notificationService.notifications.isEmpty else { return }
        await notificationService.fetchNotifications(completion: {
          print("Notifications are fetched \(notificationService.notifications.count)")
        })
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Image("appLogo")
            .resizable()
            .frame(width: 44, height: 44)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          NYCCircleImageButton(size: 20, image: Resources.Images.Settings.rate) { showFavourites() }
        }
        
        ToolbarItem(placement: .primaryAction) {
          NYCCircleImageButton(size: 20, image: Resources.Images.Settings.notifications, showBadge: !notificationService.notifications.isEmpty) { showNotifications() }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.white, for: .navigationBar)
    }
    .disabled(isLoading)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}


extension HomeView { //MARK: - Home components
  @ViewBuilder
  func locationLibrariesCollection() -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Button(action: {
        DispatchQueue.main.async {
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.libraries.headerTitle, selectedLocations: librariesLocations)))
        }
      }, label: {
        NYCSectionHeader(title: Locations.libraries.headerTitle, isExpandButton: true)
      })
      .padding(.leading, 16)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 10) {
          if isLoading {
            ForEach(0..<4) { _ in
              LoadingLocationCell()
            }
          }
          else {
            ForEach(librariesLocations,id: \.locationName) { data in
              LocationCell(data: data, type: .large, buttonAction: {
                addLocationTofavs(location: data.locationID)
              })
              .onTapGesture {
                DispatchQueue.main.async {
                  router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationDetailView(selectedLocation: data)))
                  AnalyticsManager.shared.log(.locationSelected(data.locationID))
                }
              }
            }
          }
        }
        .padding([.leading,.trailing], 16)
      }
    }
  }
  
  @ViewBuilder
  func locationLobbiesCollection() -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Button(action: {
        DispatchQueue.main.async {
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.lobbies.headerTitle, selectedLocations: hotelsLocations)))
        }
      }, label: {
        NYCSectionHeader(title: Locations.lobbies.headerTitle, isExpandButton: true)
      })
      .padding(.leading, 16)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 10) {
          if isLoading {
            ForEach(0..<4) { _ in
              LoadingLocationCell()
            }
          }
          else {
            ForEach(hotelsLocations,id: \.locationName) { data in
              LocationCell(data: data, type: .large, buttonAction: {
                addLocationTofavs(location: data.locationID)
              })
              .onTapGesture {
                DispatchQueue.main.async {
                  router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationDetailView(selectedLocation: data)))
                  AnalyticsManager.shared.log(.locationSelected(data.locationID))
                }
              }
            }
          }
        }
        .padding([.leading,.trailing], 16)
      }
    }
  }
  
  @ViewBuilder
  func locationPublicSpacesCollection() -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Button(action: {
        DispatchQueue.main.async {
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.publicSpaces.headerTitle, selectedLocations: publicSpacesLocations)))
        }
      }, label: {
        NYCSectionHeader(title: Locations.publicSpaces.headerTitle, isExpandButton: true)
      })
      .padding(.leading, 16)
      
      ZStack {
        if isLoading {
          LoadingLocationCell(type: .map)
        }
        else {
          LocationMapCard(location: publicSpacesLocations[0]) {
            addLocationTofavs(location: publicSpacesLocations[0].locationID)
          }
          .onTapGesture {
            DispatchQueue.main.async {
              router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationDetailView(selectedLocation: publicSpacesLocations[0])))
              AnalyticsManager.shared.log(.locationSelected(publicSpacesLocations[0].locationID))
            }
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func mapView() -> some View {
    VStack(alignment: .leading, spacing: 12) {
      NYCSectionHeader(title: "Locations nearby", isExpandButton: false)
      ZStack {
        LocationMapView(locations: locationService.locations, selectedLocation: .constant(Location.mock), region: Resources.mapRegion, type: .homePreview)
          .frame(width: UIScreen.main.bounds.width - 16, height: 120)
          .cornerRadius(15)
      }
      .disabled(isLoading)
      .onTapGesture {
        showMap()
      }
    }
    .padding([.leading,.trailing], 16)
  }
}

extension HomeView { //MARK: - Functions
  func addLocationTofavs(location: String) {
    Task {
      await locationService.addFavoriteLocation(locationID: location, userID: userId, completion: {
        AnalyticsManager.shared.log(.locationAddedToFavs(location))
        addToFavs.toggle()
      }) { err in
        locationService.setError(err)
      }
    }
  }
  
  func showFavourites() {
    DispatchQueue.main.async {
      AnalyticsManager.shared.log(.openFavorites)
      router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(FavoriteLocationsView()))
    }
  }
  
  func showNotifications() {
    DispatchQueue.main.async {
      AnalyticsManager.shared.log(.notificationWasOpened)
      router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(NotificationsView().environmentObject(notificationService)))
    }
  }
  
  func showMap() {
    DispatchQueue.main.async {
      AnalyticsManager.shared.log(.openMap)
      router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationsMap(locations: locationService.locations)))
    }
  }
}
