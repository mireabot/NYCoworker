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
  @StateObject var locationDataVM = LocationsHomeViewVM()
  @StateObject private var notificationService = NotificationService()
  @AppStorage("UserID") var userId : String = ""
  @State var addToFavs = false
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
                  router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.cafe.headerTitle, selectedLocations: locationDataVM.cafes)))
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
          locationDataVM.locationsData = []
        }
        await LocationService.shared.fetchLocations(completion: { result in
          switch result {
          case .success(let locactions):
            locationDataVM.locationsData = locactions
            Resources.userLocation = locationManager.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
            print("Locations are loaded \(locationDataVM.locationsData.count)")
            isLoading = false
          case .failure(let failure):
            print(failure.localizedDescription)
          }
        })
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
        await LocationService.shared.fetchLocations(completion: { result in
          switch result {
          case .success(let locactions):
            DispatchQueue.main.async {
              self.locationDataVM.locationsData = locactions
              Resources.userLocation = locationManager.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
              print("Locations are loaded \(locationDataVM.locationsData.count)")
              isLoading = false
            }
          case .failure(let failure):
            print(failure.localizedDescription)
          }
        })
        await notificationService.fetchNotifications {
          print("Notifications are fetched with count \(notificationService.notifications.count)")
        }
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
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.libraries.headerTitle, selectedLocations: locationDataVM.libraries)))
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
            ForEach(locationDataVM.libraries, id: \.locationName) { data in
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
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.lobbies.headerTitle, selectedLocations: locationDataVM.hotels)))
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
            ForEach(locationDataVM.hotels, id: \.locationName) { data in
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
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.publicSpaces.headerTitle, selectedLocations: locationDataVM.publicSpaces)))
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
          LocationMapCard(location: locationDataVM.publicSpaces[0]) {
            addLocationTofavs(location: locationDataVM.publicSpaces[0].locationID)
          }
          .onTapGesture {
            DispatchQueue.main.async {
              router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationDetailView(selectedLocation: locationDataVM.publicSpaces[0])))
              AnalyticsManager.shared.log(.locationSelected(locationDataVM.publicSpaces[0].locationID))
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
        LocationMapView(selectedLocation: .constant(Location.mock), region: Resources.mapRegion, type: .homePreview).environmentObject(locationDataVM)
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
      await LocationService.shared.addFavoriteLocation(locationID: location, userID: userId, completion: { result in
        switch result {
        case .success:
          AnalyticsManager.shared.log(.locationAddedToFavs(location))
          addToFavs.toggle()
        case .failure(let error):
          print(firestoreError(forError: error))
        }
      })
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
      router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationsMap().environmentObject(locationDataVM)))
    }
  }
}
