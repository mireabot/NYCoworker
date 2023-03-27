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
    @State var timer = false
    @StateObject var locationVM : LocationsViewModel = .shared
    @State var showMap = false
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
            //        .onAppear {
            //            timer = true
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            //                self.timer = false
            //            }
            //        }
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
                LocationListView(title: Locations.libraries.rawValue)
            } label: {
                NYCSectionHeader(title: Locations.libraries.rawValue, isExpandButton: true)
            }

            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(locationVM.librariesLocations) { data in
                        if timer {
                            LocationCell(data: data, type: .small)
                                .redacted(reason: .placeholder)
                                .shimmering(active: true, duration: 1.5, bounce: false)
                        }
                        else {
                            NavigationLink(destination: LocationDetailView(locationData: data)) {
                                LocationCell(data: data, type: .small)
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
            NavigationLink(destination: LocationListView(title: Locations.lobbies.rawValue)) {
                NYCSectionHeader(title: Locations.lobbies.rawValue, isExpandButton: true)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(locationVM.locations) { data in
                        if timer {
                            LocationCell(data: data, type: .large)
                                .redacted(reason: .placeholder)
                                .shimmering(active: true, duration: 1.5, bounce: false)
                        }
                        else {
                            NavigationLink(destination: LocationDetailView(locationData: data)) {
                                LocationCell(data: data, type: .large)
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
                
                NavigationLink(destination: LocationsMapView(), label: {
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
