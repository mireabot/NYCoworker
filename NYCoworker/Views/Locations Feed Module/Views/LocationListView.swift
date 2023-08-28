//
//  LocationListView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import PopupView

struct LocationListView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  @AppStorage("UserID") var userId : String = ""
  var selectedTitle: String
  var selectedLocations: [Location]
  @State private var selectedLocation: Location?
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        locationsList()
      }
      .fullScreenCover(item: $selectedLocation, content: { locationData in
        LocationDetailView(selectedLocation: locationData).disableRefresh()
      })
      .padding([.leading,.trailing], 16)
      .toolbarBackground(.white, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            router.nav?.popViewController(animated: true)
          } label: {
            Resources.Images.Navigation.arrowBack
              .foregroundColor(Resources.Colors.primary)
          }
          
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
          Text(selectedTitle)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 17))
        }
      }
    }
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
      ForEach(selectedLocations){ location in
        LocationListCell(type: .list, data: location, buttonAction: {})
          .onTapGesture {
            selectedLocation = location
            AnalyticsManager.shared.log(.locationSelected(location.locationID))
          }
      }
    }
  }
}
