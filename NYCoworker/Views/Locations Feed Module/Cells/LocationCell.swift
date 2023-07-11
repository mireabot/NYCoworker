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
///    - type: Type of cell taken from enum LocationCellType / small or large
struct LocationCell: View {
  @StateObject var locationManager = LocationManager()
    enum LocationCellType {
        case small
        case large
    }
    var data: Location
    let type: LocationCellType?
    var buttonAction: () -> Void
    var body: some View {
        switch type {
        case .small:
            smallCard(withData: data)
        case .large:
            largeCard(withData: data)
        case .none:
            smallCard(withData: data)
        }
    }
}
/// Views constructors for location cells
///
/// Extension of LocationCell struct
extension LocationCell {
    /// ViewBuilder for large location card cell
    ///  - Parameters:
    ///     - data: Location data from LocationModel
    @ViewBuilder
    func largeCard(withData data: Location) -> some View {
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
                    
                    Button {
                        buttonAction()
                    } label: {
                        Image("add")
                            .resizable()
                            .foregroundColor(Resources.Colors.customBlack)
                            .frame(width: 15, height: 15)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(15)
                            .offset(x: -6, y: 6)
                    }
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
    /// ViewBuilder for small location card cell
    ///  - Parameters:
    ///     - data: Location data from LocationModel
    @ViewBuilder
    func smallCard(withData data: Location) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .topTrailing) {
                WebImage(url: data.locationImages[0]).placeholder {
                    Image("load")
                        .resizable()
                }
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 100)
                .cornerRadius(10)
                
                Button {
                    buttonAction()
                } label: {
                    Image("add")
                        .resizable()
                        .foregroundColor(Resources.Colors.customBlack)
                        .frame(width: 15, height: 15)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(15)
                        .offset(x: -6, y: 6)
                }

            }
            
            HStack(spacing: 3) {
                ForEach(data.locationTags,id: \.self) { title in
                    NYCBadgeView(badgeType: .withWord, title: title)
                }
            }
            
            Text(data.locationName)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 13))
                .lineLimit(0)
            
            HStack(spacing: 4) {
                Text(String(format: "%.1f", calculateDistance(from: Resources.userLocation, to: data.locationCoordinates)) + " mi · ")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
                RatingDotsView(number: data.reviews)
            }
        }
        .frame(width: 120)
    }
}


struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
      LocationCell(data: Location.mock, type: .large, buttonAction: {})
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
