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
    @State var isUpdating = false
    @EnvironmentObject var userService : UserService
    @StateObject var locationService = LocationService()
    @AppStorage("UserID") var userId : String = ""
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
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                await extractedFunc()
                            }
                        } label: {
                            Resources.Images.Navigation.refresh
                                .foregroundColor(Resources.Colors.primary)
                        }
                        
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
    fileprivate func extractedFunc() async {
        isLoading = true
        locationService.favoriteLocations = []
        await userService.fetchUser(documentId: userId, completion: {
            print("User fetched again")
        })
        await locationService.fetchFavoriteLocations(for: userService.user) {
            isLoading = false
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
                    List{
                        ForEach(locationService.favoriteLocations, id: \.id) { data in
                            ZStack(alignment: .leading) {
                                LocationListCell(type: .favorite, data: data, buttonAction: {})
                                NavigationLink(destination: LocationDetailView(locationData: data)) {
                                    EmptyView()
                                }
                            }
                            .listRowSeparator(.hidden)
                        }
//                        .onDelete(perform: { indexSet in
//                            for index in indexSet {
//                                isUpdating = true
//                                Task {
//                                    try await locationService.deleteFavoriteLocation(at: index, for: userId) {
//                                        isUpdating = false
//                                    }
//                                }
//                            }
//                        })
//                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//                            ForEach(locationService.favoriteLocations.indices,id: \.self) { index in
//                                Button(role: .destructive) {
//                                    isUpdating = true
//                                    Task {
//                                        try await locationService.deleteFavoriteLocation(at: index, for: userId) {
//                                            isUpdating = false
//                                        }
//                                    }
//                                } label: {
//                                    Text("Delete")
//                                        .font(Resources.Fonts.regular(withSize: 15))
//                                }
//                                .tint(Resources.Colors.secondary)
//                            }
//                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .overlay(content: {
            LoadingBottomView(title: "Hold on a minute", show: $isUpdating)
        })
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

//Button(role: .destructive) {
//    isUpdating = true
//} label: {
//    Text("Delete")
//        .font(Resources.Fonts.regular(withSize: 15))
//}
//.tint(Resources.Colors.secondary)
