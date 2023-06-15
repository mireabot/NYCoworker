//
//  LocationListView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import PopupView

struct LocationListView: View {
  @Environment(\.dismiss) var makeDismiss
  @EnvironmentObject var locationService: LocationService
  @State var addToFavs = false
  var locationType: Locations
  @AppStorage("UserID") var userId : String = ""
  init(type: Locations) {
    self.locationType = type
  }
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      switch locationType {
      case .libraries:
        libraryLocations()
      case .lobbies:
        hotelsLocations()
      case .publicSpaces:
        publicSpacesLocations()
      }
    }
    .padding([.leading,.trailing], 16)
    .popup(isPresented: $addToFavs) {
      NYCAlertNotificationView(alertStyle: .addedToFavorites)
    } customize: {
      $0
        .isOpaque(true)
        .autohideIn(1.5)
        .type(.floater())
        .position(.top)
        .animation(.spring(response: 0.4, blendDuration: 0.2))
    }
    .toolbarBackground(.white, for: .navigationBar)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          makeDismiss()
        } label: {
          Resources.Images.Navigation.arrowBack
            .foregroundColor(Resources.Colors.primary)
        }
        
      }
      
      ToolbarItem(placement: .navigationBarLeading) {
        Text(locationType.headerTitle)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 17))
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
  }
}

//struct LocationListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationListView()
//    }
//}

extension LocationListView { //MARK: - View components
  @ViewBuilder
  func hotelsLocations() -> some View {
    LazyVStack(spacing: 12) {
      ForEach(locationService.locations){ location in
        if location.locationType == .hotel {
          NavigationLink(value: location) {
            LocationListCell(type: .list, data: location) {
              Task {
                do {
                  await locationService.addFavoriteLocation(locationID: location.locationID, userID: userId, completion: {
                    addToFavs.toggle()
                  }) { err in
                    print(err.localizedDescription)
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func libraryLocations() -> some View {
    LazyVStack(spacing: 12) {
      ForEach(locationService.locations){ location in
        if location.locationType == .library {
          NavigationLink(value: location) {
            LocationListCell(type: .list, data: location) {
              Task {
                do {
                  await locationService.addFavoriteLocation(locationID: location.locationID, userID: userId, completion: {
                    addToFavs.toggle()
                  }) { err in
                    print(err.localizedDescription)
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func publicSpacesLocations() -> some View {
    LazyVStack(spacing: 12) {
      ForEach(locationService.locations){ location in
        if location.locationType == .publicSpace {
          NavigationLink(value: location) {
            LocationListCell(type: .list, data: location) {
              Task {
                do {
                  await locationService.addFavoriteLocation(locationID: location.locationID, userID: userId, completion: {
                    addToFavs.toggle()
                  }) { err in
                    print(err.localizedDescription)
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
