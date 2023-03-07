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
    @State var presentFavoritesView = false
    @State var presentNotifications = false
    @State var timer = false
    @State var locationTitle = ""
    @State var presentMap = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7181597, longitude: -73.9845737), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @StateObject var locationVM : LocationsViewModel = .shared
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            /// Map section
            VStack(alignment: .leading, spacing: 15) {
                NYCSectionHeader(title: "Locations nearby", isExpandButton: false)
                
                ZStack {
                    Map(coordinateRegion: $region)
                        .frame(width: UIScreen.main.bounds.width - 16, height: 100)
                        .cornerRadius(10)
                        .disabled(true)
                    
                    Button {
                        presentMap.toggle()
                    } label: {
                        Text("Open map")
                    }
                    .buttonStyle(NYCActionButtonStyle())
                    .padding([.leading,.trailing], 90)
                }
            }
            .padding([.leading,.trailing], 20)
            .padding(.top, 20)
            
            /// Locations section
            VStack(alignment: .leading, spacing: 15) {
                /// Category scrollview
                VStack(alignment: .leading, spacing: 10) {
                    NavigationLink(destination: LocationListView(title: Locations.libraries.rawValue)) {
                        NYCSectionHeader(title: Locations.libraries.rawValue, isExpandButton: true)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<10) {_ in
                                if timer {
                                    LocationCell()
                                        .redacted(reason: .placeholder)
                                        .shimmering(active: true, duration: 1.5, bounce: false)
                                }
                                else {
                                    NavigationLink(destination: LocationDetailView(), label: {
                                        LocationCell()
                                    })
                                }
                            }
                        }
                    }
                }
                
                /// Category scrollview
                VStack(alignment: .leading, spacing: 10) {
                    NavigationLink(destination: LocationListView(title: Locations.lobbies.rawValue)) {
                        NYCSectionHeader(title: Locations.lobbies.rawValue, isExpandButton: true)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<10) {_ in
                                if timer {
                                    LocationCell()
                                        .redacted(reason: .placeholder)
                                        .shimmering(active: true, duration: 1.5, bounce: false)
                                }
                                else {
                                    LocationCell()
                                }
                            }
                        }
                    }
                }
            }
            .padding([.leading,.trailing], 20)
            .padding(.top, 50)
        }
        .navigationDestination(isPresented: $presentFavoritesView, destination: {
            FavoriteView()
        })
        .navigationDestination(isPresented: $presentNotifications, destination: {
            NotificationsView()
        })
        .navigationDestination(isPresented: $presentMap, destination: {
            LocationsMapView(locationVM: .shared)
        })
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
                NYCCircleImageButton(size: 20, image: Image("rate")) {
                    presentFavoritesView.toggle()
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                NYCCircleImageButton(size: 20, image: Image("bell")) {
                    presentNotifications.toggle()
                }
            }
        }
        .toolbarBackground(.white, for: .navigationBar, .automatic)
        .hideTabbar(shouldHideTabbar: false)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
