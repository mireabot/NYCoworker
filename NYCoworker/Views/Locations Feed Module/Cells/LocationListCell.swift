//
//  LocationListCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreLocation
import Firebase
/// Location cell for list views / favorites and detail list by location category
///
///  - Parameters:
///    - type: Type of cell taken from enum CellType
///    - data: Data about location taken from LocationModel
///    - buttonAction: Action from button inside cell -> passes func to root view
struct LocationListCell: View {
  /// Enum defines cell type
  ///
  ///  - Parameters:
  ///     - list: Used in detailed view when showed all locations of exact type · Adds action button for cell
  ///     - favorite: Used in list of favorite location · Hides action button
  enum CellType {
    case list
    case favorite
  }
  var type: CellType
  var data: Location
  var buttonAction: () -> Void
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      ZStack(alignment: .topTrailing) {
        WebImage(url: data.locationImages[0]).placeholder {
          Image("load")
            .resizable()
        }
        .resizable()
        .scaledToFill()
        .frame(height: 150)
        .cornerRadius(10)
        
        HStack(alignment: .center) {
          NYCRateBadge(rate: data.reviews, badgeType: .card)
            .offset(x: 6, y: 6)
          Spacer()
          Button {
            buttonAction()
          } label: {
            Image(type == .list ? "add" : "close")
              .resizable()
              .foregroundColor(Resources.Colors.customBlack)
              .frame(width: 20, height: 20)
              .padding(5)
              .background(Color.white)
              .cornerRadius(20)
              .offset(x: -6, y: 6)
          }
        }
      }
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 3) {
          HStack(spacing: 3) {
            ForEach(data.locationTags,id: \.self) { title in
              NYCBadgeView(badgeType: .withWord, title: title)
            }
          }
          Text(data.locationName)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.regular(withSize: 20))
            .multilineTextAlignment(.leading)
          Text(data.locationAddress)
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 13))
        }
        Spacer()
        if Resources.userLocation == CLLocation(latitude: 0.0, longitude: 0.0) {
          Text(String(format: "%.1f", calculateDistance(from: Resources.userLocation, to: data.locationCoordinates)) + " mi · ")
              .foregroundColor(Resources.Colors.darkGrey)
              .font(Resources.Fonts.regular(withSize: 15))
        }
      }
    }
  }
}

extension LocationListCell {
  func calculateDistance(from userLocation: CLLocation, to locationGeoPoint: GeoPoint) -> Double {
    let location = CLLocation(latitude: locationGeoPoint.latitude, longitude: locationGeoPoint.longitude)
    let distance = userLocation.distance(from: location) / 1000 // convert to kilometers
    let distanceInMiles = distance * 0.621371 // convert to miles
    return round(distanceInMiles * 100) / 100 // round to 2 decimal places
  }
}

//struct LocationListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationListCell(type: .list, buttonAction: ())
//    }
//}
