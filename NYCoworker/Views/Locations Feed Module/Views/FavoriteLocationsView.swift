//
//  FavoriteView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI
import PopupView
import Firebase

struct FavoriteLocationsView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  @State var isLoading = true
  @State var isUpdating = false
  @StateObject private var userService = UserService()
  @StateObject private var locationService = LocationService()
  @AppStorage("UserID") var userId : String = ""
  var body: some View {
    NavigationView {
      favoriteList()
        .onAppear {
          isLoading = true
          Task(priority: .userInitiated) {
            do {
              await userService.fetchUser(documentId: userId, completion: {
                Task(priority: .userInitiated) {
                  await locationService.fetchFavoriteLocations(for: userService.user) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                      print("Favorites locations for userID \(userService.user.userID) fetched with count \(locationService.favoriteLocations.count)")
                      isLoading = false
                    }
                  }
                }
              })
            }
          }
        }
        .toolbar(content: {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              router.nav?.popViewController(animated: true)
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
        })
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteLocationsView()
  }
}

extension FavoriteLocationsView { //MARK: - View components
  @ViewBuilder
  func favoriteList() -> some View {
    VStack {
      if isLoading {
        loadingView()
      }
      else {
        if locationService.favoriteLocations.isEmpty {
          NYCEmptyView(type: .favorites)
        }
        else {
          ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 16) {
              ForEach(locationService.favoriteLocations, id: \.id) { data in
                LocationListCell(type: .favorite, data: data, buttonAction: {
                  removeFromfavs(locationID: data.locationID)
                  Task {
                    await extractedFunc()
                  }
                })
                .onTapGesture {
                  router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(LocationDetailView(selectedLocation: data)))
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

extension FavoriteLocationsView { //MARK: - Functions
  fileprivate func extractedFunc() async {
    isLoading = true
    locationService.favoriteLocations = []
    await userService.fetchUser(documentId: userId, completion: {
      Task(priority: .userInitiated) {
        await locationService.fetchFavoriteLocations(for: userService.user) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            print("Favorites locations for userID \(userId) fetched with count \(locationService.favoriteLocations)")
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
}
