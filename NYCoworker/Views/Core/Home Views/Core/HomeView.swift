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
    @StateObject var locationManager = LocationManager()
    @StateObject private var locationService = LocationService()
    @EnvironmentObject var userService : UserService
    @AppStorage("UserID") var userId : String = ""
    @State var addToFavs = false
    var body: some View {
        NavigationView {
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
//                .padding(.bottom, 10)
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
                    NavigationLink(destination: FavoriteView().environmentObject(userService)) {
                        NYCCircleImageButton(size: 20, image: Image("rate")) {}.disabled(true)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: NotificationsView()) {
                        NYCCircleImageButton(size: 20, image: Image("bell")) {}.disabled(true)
                    }
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
            NavigationLink {
                LocationListView(title: Locations.libraries.rawValue, type: .library).environmentObject(locationService)
            } label: {
                NYCSectionHeader(title: Locations.libraries.rawValue, isExpandButton: true)
            }.padding(.leading, 20)
            
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
                                NavigationLink(destination: LocationDetailView(locationData: data)) {
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
            NavigationLink {
                LocationListView(title: Locations.lobbies.rawValue, type: .hotel).environmentObject(locationService)
            } label: {
                NYCSectionHeader(title: Locations.lobbies.rawValue, isExpandButton: true)
            }
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
                                NavigationLink(destination: LocationDetailView(locationData: data)) {
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
            NavigationLink {
                LocationListView(title: Locations.publicSpaces.rawValue, type: .publicSpace).environmentObject(locationService)
            } label: {
                NYCSectionHeader(title: Locations.publicSpaces.rawValue, isExpandButton: true)
            }.padding(.leading, 20)
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
                                NavigationLink(destination: LocationDetailView(locationData: data)) {
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
