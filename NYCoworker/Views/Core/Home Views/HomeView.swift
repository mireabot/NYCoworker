//
//  HomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import Shimmer

struct HomeView: View {
    @State var presentFavoritesView = false
    @State var presentLocationList = false
    @State var timer = false
    @State var locationTitle = ""
    @State var presentMap = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            /// Map section
            VStack(alignment: .leading, spacing: 15) {
                NYCSectionHeader(title: "Locations nearby", isExpandButton: false)
                
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 16, height: 100)
                        .cornerRadius(10)
                    
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
                    NYCSectionHeader(title: Locations.libraries.rawValue, isExpandButton: true)
                        .onTapGesture {
                            locationTitle = Locations.libraries.rawValue
                            presentLocationList.toggle()
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
                
                /// Category scrollview
                VStack(alignment: .leading, spacing: 10) {
                    NYCSectionHeader(title: Locations.lobbies.rawValue, isExpandButton: true)
                        .onTapGesture {
                            locationTitle = Locations.lobbies.rawValue
                            presentLocationList.toggle()
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
        .navigationDestination(isPresented: $presentLocationList, destination: {
            LocationListView(title: locationTitle)
        })
        .fullScreenCover(isPresented: $presentMap, content: {
            LocationsMapView()
        })
        .onAppear {
            timer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.timer = false
            }
        }
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
        }
        .toolbarBackground(.white, for: .navigationBar, .automatic)
        .hideTabbar(shouldHideTabbar: false)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
