//
//  LocationCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreLocation
import Firebase
/// Location cell viewModel
///
/// Used in home screen locations collection
///
///  - Parameters:
///    - data: Data about location taken from LocationModel
struct LocationCell: View {
  @StateObject var locationManager = LocationManager()
  var data: Location
  var body: some View {
    VStack(alignment: .leading, spacing: 2) {
      ZStack(alignment: .bottomLeading) {
        ZStack(alignment: .topTrailing) {
          WebImage(url: data.locationImages[0]).placeholder {
            Image("load")
              .resizable()
          }
          .resizable()
          .scaledToFill()
          .frame(width: 180, height: 110)
          .cornerRadius(15)
        }
        HStack(spacing: 5) {
          ForEach(data.locationTags,id: \.self){ title in
            NYCBadgeView(badgeType: .withWord, title: title)
          }
        }
        .offset(x: 6, y: -6)
      }
      VStack(alignment: .leading, spacing: 2) {
        Text(data.locationName)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.regular(withSize: 16))
          .lineLimit(0)
        HStack(spacing: 4) {
          if !Resources.locationLocked {
            Text(String(format: "%.1f", calculateDistance(from: Resources.userLocation, to: data.locationCoordinates)) + " mi · ")
              .foregroundColor(Resources.Colors.darkGrey)
              .font(Resources.Fonts.regular(withSize: 13))
          }
          
          RatingDotsView(number: data.reviews)
        }
      }
    }.frame(width: 180)
  }
}

struct LocationCell_Previews: PreviewProvider {
  static var previews: some View {
    LocationCell(data: Location.mock)
  }
}

extension LocationCell {
  func calculateDistance(from userLocation: CLLocation, to locationGeoPoint: GeoPoint) -> Double {
    let location = CLLocation(latitude: locationGeoPoint.latitude, longitude: locationGeoPoint.longitude)
    let distance = userLocation.distance(from: location) / 1000 // convert to kilometers
    let distanceInMiles = distance * 0.621371 // convert to miles
    return round(distanceInMiles * 100) / 100 // round to 2 decimal places
  }
}
