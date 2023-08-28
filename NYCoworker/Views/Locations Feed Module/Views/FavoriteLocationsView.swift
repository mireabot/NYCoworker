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
  @StateObject private var userService = UserService()
  @StateObject private var locationStore = LocationStore()
  @AppStorage("UserID") var userId : String = ""
  @State private var selectedLocation: Location?
  var body: some View {
    NavigationView {
      favoriteList()
        .fullScreenCover(item: $selectedLocation, content: { locationData in
          LocationDetailView(selectedLocation: locationData)
        })
        .task {
          await fetchFavoriteLocations()
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
        if locationStore.favoriteLocations.isEmpty {
          NYCEmptyView(type: .favorites)
        }
        else {
          ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 16) {
              ForEach(locationStore.favoriteLocations, id: \.id) { data in
                LocationListCell(type: .favorite, data: data, buttonAction: {
                  removeLocationFromFavorites(locationID: data.locationID)
                  Task {
                    await fetchFavoriteLocations()
                  }
                })
                .onTapGesture {
                  selectedLocation = data
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
  func removeLocationFromFavorites(locationID: String) {
    Task {
      if userService.user.favoriteLocations.contains(locationID) {
        await LocationService.shared.removeLocationFromFavorites(for: userId, with: locationID) { result in
          switch result {
          case .success:
            print("Location \(locationID) deleted")
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
      }
      else {
        return
      }
    }
  }
  
  private func fetchFavoriteLocations() async {
    isLoading = true
    await userService.fetchUser(documentId: userId, completion: {
      Task(priority: .userInitiated) {
        await locationStore.fetchFavoriteLocations(for: userService.user, completion: { result in
          switch result {
          case .success:
            print("Favorites locations for userID \(userService.user.userID) fetched with count \(locationStore.favoriteLocations.count)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
              isLoading = false
            }
          case .failure(let error):
            print(error.localizedDescription)
          }
        })
      }
    })
  }
}
