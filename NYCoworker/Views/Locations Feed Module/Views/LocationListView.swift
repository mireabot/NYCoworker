//
//  LocationListView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import PopupView

struct LocationListView: View {
  @EnvironmentObject var navigationFlow: LocationModuleNavigationFlow
  @StateObject private var locationService = LocationService()
  @State var addToFavs = false
  @AppStorage("UserID") var userId : String = ""
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      locationsList()
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
          navigationFlow.backToPrevious()
        } label: {
          Resources.Images.Navigation.arrowBack
            .foregroundColor(Resources.Colors.primary)
        }
        
      }
      
      ToolbarItem(placement: .navigationBarLeading) {
        Text(navigationFlow.selectedListTitle)
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
  func locationsList() -> some View {
    LazyVStack(spacing: 12) {
      ForEach(navigationFlow.selectedSetOfLocations){ location in
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
        .onTapGesture {
          navigationFlow.selectedLocation = location
          navigationFlow.navigateToDetailView()
        }
      }
    }
  }
}
