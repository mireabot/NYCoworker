//
//  FavoriteView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI
import PopupView

struct FavoriteView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var isLoading = true
    @EnvironmentObject var userService : UserService
    @StateObject private var locationService = LocationService()
    var body: some View {
        NavigationStack {
            favoriteList()
                .navigationDestination(for: Location.self, destination: { location in
                    LocationDetailView(locationData: location)
                })
                .toolbar(.hidden, for: .tabBar)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            makeDismiss()
                        } label: {
                            Resources.Images.Navigation.arrowBack
                                .foregroundColor(Resources.Colors.primary)
                        }
                        
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Your favorites")
                            .foregroundColor(Resources.Colors.customBlack)
                            .font(Resources.Fonts.bold(withSize: 17))
                    }
                })
                .navigationBarTitleDisplayMode(.inline)
            
        }
        .navigationBarBackButtonHidden()
        .toolbarBackground(.white, for: .navigationBar)
    }
    
    @ViewBuilder
    func emptyState() -> some View {
        VStack {
            FavoritesEmptyView()
        }
    }
    @ViewBuilder
    func favoriteList() -> some View {
        VStack {
            if isLoading {
                ProgressView()
            }
            else {
                if locationService.favoriteLocations.isEmpty {
                    emptyState()
                }
                else {
                    List(locationService.favoriteLocations,id: \.locationName) { data in
                        ZStack(alignment: .leading) {
                            LocationListCell(type: .favorite, data: data, buttonAction: {})
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        
                                    } label: {
                                        Text("Delete")
                                            .font(Resources.Fonts.regular(withSize: 15))
                                    }
                                    .tint(Resources.Colors.secondary)
                                }
                            NavigationLink(destination: LocationDetailView(locationData: data)) {
                                EmptyView()
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
        }
        .task {
            await locationService.fetchFavoriteLocations(for: userService.user) {
                isLoading = false
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
