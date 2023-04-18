//
//  FavoriteView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI
import PopupView
import Firebase

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
                    ScrollView(.vertical, showsIndicators: true) {
                        LazyVStack {
                            ForEach(locationService.favoriteLocations, id: \.id) { data in
                                NavigationLink(destination: LocationDetailView(locationData: data)) {
                                    LocationListCell(type: .favorite, data: data, buttonAction: {
                                        removeFromfavs(locationID: data.locationID)
                                        Task {
                                            await extractedFunc()
                                        }
                                    })
                                }
                            }
                        }
                    }
                    .padding([.leading,.trailing], 16)
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
    
    func removeFromfavs(locationID: String) {
        Task {
            if userService.user.favoriteLocations.contains(locationID) {
                Firestore.firestore().collection(Endpoints.users.rawValue).document(userId).updateData([
                    "favoriteLocations": FieldValue.arrayRemove([locationID])
                ])
            }
            else {
                return
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
