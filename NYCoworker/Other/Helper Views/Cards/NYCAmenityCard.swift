//
//  AmenityCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/16/23.
//

import SwiftUI

struct NYCAmenityCard: View {
  var data: String
  var body: some View {
    HStack(alignment: .center, spacing: 5) {
      amenitiesImage(image: data)
        .foregroundColor(Resources.Colors.customBlack)
      Text(data)
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 15))
    }
    .padding(2)
  }
  
  func amenitiesImage(image: String) -> Image {
    switch image {
    case "W/C":
      return LocationR.Amenities.wc
    case "A/C":
      return LocationR.Amenities.ac
    case "Pet friendly":
      return LocationR.Amenities.pets
    case "Rooftop":
      return LocationR.Amenities.rooftop
    case "Charging":
      return LocationR.Amenities.charge
    case "Wi-Fi":
      return LocationR.Amenities.wifi
    case "Quiet space":
      return LocationR.Amenities.silient
    case "Bar":
      return LocationR.Amenities.bar
    case "Work station":
      return LocationR.Amenities.printer
    case "Outdoor space":
      return LocationR.Amenities.outdoor
    case "Food store":
      return LocationR.Amenities.store
    case "Meeting room":
      return LocationR.Amenities.meeting
    case "Accessible":
      return LocationR.Amenities.accessible
    default:
      return LocationR.Amenities.wc
    }
  }
}

//struct AmenityCard_Previews: PreviewProvider {
//    static var previews: some View {
////        AmenityCard(data: amenityData[0])
//        WorkingHoursCard(data: hoursData[5])
//    }
//}
//

struct NYCWorkingHoursCard: View {
  var data: WorkingHours
  var body: some View {
    VStack(spacing: 5) {
      Text(data.weekDay)
        .foregroundColor(Resources.Colors.darkGrey)
        .font(Resources.Fonts.regular(withSize: 15))
      Text(data.hours)
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 15))
    }
    .padding(10)
    .background(Resources.Colors.customGrey)
    .cornerRadius(5)
  }
}
