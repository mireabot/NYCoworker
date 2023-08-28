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
  @StateObject private var locationStore = LocationStore()
  @StateObject private var notificationStore = NotificationStore()
  @AppStorage("UserID") var userId : String = ""
  @State private var selectedLocation: Location?
  @State private var showMap = false
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
                  router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.cafe.headerTitle, selectedLocations: locationStore.cafes)))
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
      .fullScreenCover(item: $selectedLocation, content: { location in
        LocationDetailView(selectedLocation: location).disableRefresh()
      })
      .fullScreenCover(isPresented: $showMap, content: {
        LocationsMapView().environmentObject(locationStore)
      })
      .refreshable(action: {
        DispatchQueue.main.async {
          isLoading = true
        }
        await fetchAllLocations()
        await fetchNotifications()
      })
      .task {
        await fetchAllLocations()
        await fetchNotifications()
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
          NYCCircleImageButton(size: 20, image: Resources.Images.Settings.notifications, showBadge: !notificationStore.notifications.isEmpty) { showNotifications() }
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
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.libraries.headerTitle, selectedLocations: locationStore.libraries)))
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
            ForEach(locationStore.libraries, id: \.locationName) { data in
              LocationCell(data: data)
                .onTapGesture {
                  DispatchQueue.main.async {
                    selectedLocation = data
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
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.lobbies.headerTitle, selectedLocations: locationStore.hotels)))
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
            ForEach(locationStore.hotels, id: \.locationName) { data in
              LocationCell(data: data)
                .onTapGesture {
                  DispatchQueue.main.async {
                    selectedLocation = data
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
          router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationListView(selectedTitle: Locations.publicSpaces.headerTitle, selectedLocations: locationStore.publicSpaces)))
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
          LocationMapCard(location: locationStore.publicSpaces[0])
            .onTapGesture {
              DispatchQueue.main.async {
                selectedLocation = locationStore.publicSpaces[0]
                AnalyticsManager.shared.log(.locationSelected(locationStore.publicSpaces[0].locationID))
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
        NYCMap(locations: $locationStore.locations, selectedLocation: .constant(Location.mock), region: Resources.mapRegion, type: .homePreview)
          .frame(width: UIScreen.main.bounds.width - 16, height: 120)
          .cornerRadius(15)
      }
      .disabled(isLoading)
      .onTapGesture {
        showMap.toggle()
      }
    }
    .padding([.leading,.trailing], 16)
  }
}

extension HomeView { //MARK: - Functions
  
  private func fetchAllLocations() async {
    await locationStore.fetchLocations(completion: { result in
      switch result {
      case .success:
        Resources.userLocation = locationManager.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
        print("Locations are loaded \(locationStore.locations.count)")
        isLoading = false
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }
  
  private func fetchNotifications() async {
    await notificationStore.fetchNotifications(completion: { result in
      switch result {
      case .success:
        print("Notifications are fetched \(notificationStore.notifications.count)")
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
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
      router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(NotificationsView().environmentObject(notificationStore)))
    }
  }
}
