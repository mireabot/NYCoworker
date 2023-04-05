//
//  HomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import Shimmer
import MapKit

struct HomeView: View {
    @State var isLoading = true
    @State var showMap = false
    @StateObject private var locationService = LocationService()
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                /// Map section
                mapView()
                /// Locations section
                VStack(alignment: .leading, spacing: 15) {
                    /// Category scrollview
                    locationLibrariesCollection()
                    
                    /// Category scrollview
                    locationLobbiesCollection()
                }
                .padding([.leading,.trailing], 20)
                .padding(.top, 30)
            }
            .task {
                guard locationService.locations.isEmpty else { return }
                await locationService.fetchLoactions {
                    isLoading = false
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("appLogo")
                        .resizable()
                        .frame(width: 44, height: 44)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoriteView()) {
                        NYCCircleImageButton(size: 20, image: Image("rate")) {}.disabled(true)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: NotificationsView()) {
                        NYCCircleImageButton(size: 20, image: Image("bell")) {}.disabled(true)
                    }
                }
            }
            .toolbarBackground(.white, for: .navigationBar, .automatic)
            .hideTabbar(shouldHideTabbar: false)
            .navigationBarTitleDisplayMode(.inline)
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
            }
            
            
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
                                    LocationCell(data: data, type: .small)
                                }
                            }
                        }
                    }
                }
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
                                    LocationCell(data: data, type: .large)
                                }
                            }
                        }
                    }
                }
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
                
                NavigationLink(destination: LocationsMap().environmentObject(locationService), label: {
                    Text("Open map")
                        .foregroundColor(Color.white)
                        .padding([.top,.bottom], 15)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Resources.Colors.primary))
                        .cornerRadius(10)
                })
                .padding([.leading,.trailing], 90)
            }
        }
        .padding([.leading,.trailing], 20)
        .padding(.top, 20)
    }
}
