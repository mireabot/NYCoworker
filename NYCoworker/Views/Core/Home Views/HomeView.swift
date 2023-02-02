//
//  HomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI

struct HomeView: View {
    @State var presentFavoritesView = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                /// Map section
                VStack(alignment: .leading, spacing: 15) {
                    NYCSectionHeader(title: "Locations nearby", isExpandButton: false)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width - 16, height: 100)
                            .cornerRadius(10)
                        
                        Button {
                            
                        } label: {
                            Text("Open map")
                                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
                        }
                        .buttonStyle(NYCActionButtonStyle())
                    }
                }
                .padding([.leading,.trailing], 20)
                .padding(.top, 20)
                
                /// Locations section
                VStack(alignment: .leading, spacing: 15) {
                    /// Category scrollview
                    VStack(alignment: .leading, spacing: 10) {
                        NYCSectionHeader(title: "Silent libraries", isExpandButton: true)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<10) {_ in
                                    LocationCell()
                                }
                            }
                        }
                    }
                    
                    /// Category scrollview
                    VStack(alignment: .leading, spacing: 10) {
                        NYCSectionHeader(title: "Stunning lobbies", isExpandButton: true)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<10) {_ in
                                    LocationCell()
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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
