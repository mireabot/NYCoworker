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
  @State var isLoading = true
  @State var isUpdating = false
  @EnvironmentObject var userService : UserService
  @EnvironmentObject var navigationState: NavigationDestinations
  @StateObject var locationService = LocationService()
  @AppStorage("UserID") var userId : String = ""
  var body: some View {
    favoriteList()
      .onAppear {
        isLoading = true
        Task(priority: .userInitiated) {
          do {
            await locationService.fetchFavoriteLocations(for: userService.user) {
              isLoading = false
            }
          }
        }
      }
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            dismiss()
          } label: {
            Resources.Images.Navigation.arrowBack
              .foregroundColor(Resources.Colors.primary)
          }
          
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
          Text("Your favorites")
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 17))
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
      .navigationBarBackButtonHidden()
      .toolbarBackground(.white, for: .navigationBar)
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteView().environmentObject(UserService()).environmentObject(NavigationDestinations())
  }
}

extension FavoriteView { //MARK: - View components
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
        loadingView()
      }
      else {
        if locationService.favoriteLocations.isEmpty {
          emptyState()
        }
        else {
          ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 16) {
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
  }
  
  @ViewBuilder
  func loadingView() -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack {
        ForEach(0..<3){ item in
          LoadingLocationCell(type: .list)
        }
      }.padding([.leading,.trailing], 16)
    }.scrollDisabled(true)
  }
}

extension FavoriteView { //MARK: - Functions
  fileprivate func extractedFunc() async {
    isLoading = true
    locationService.favoriteLocations = []
    await userService.fetchUser(documentId: userId, completion: {
      Task {
        await locationService.fetchFavoriteLocations(for: userService.user) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
          }
        }
      }
    })
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
  
  func dismiss() {
    navigationState.isPresentingFavourites = false
  }
}
