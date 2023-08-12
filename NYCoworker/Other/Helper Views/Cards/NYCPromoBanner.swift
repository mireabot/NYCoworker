//
//  NYCPromoBanner.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/6/23.
//

import SwiftUI

enum BannerType {
  case summerLocations
  case suggestLocation
  
  var title: String {
    switch self {
    case .summerLocations:
      return "Explore cool summer getaways"
    case .suggestLocation:
      return "Discover connections at your spot"
    }
  }
  
  var text: String {
    switch self {
    case .summerLocations:
      return "Enjoy sunny days while working outside"
    case .suggestLocation:
      return "Add your favorite working spot to map and start networking"
    }
  }
  
  var image: Image {
    switch self {
    case .summerLocations:
      return Image("summerPromo")
    case .suggestLocation:
      return Image("suggestLocation")
    }
  }
  
  var buttonText: String {
    switch self {
    case .summerLocations:
      return "Explore"
    case .suggestLocation:
      return "Add location"
    }
  }
}

struct NYCPromoBanner: View {
  var bannerType: BannerType
  var action: () -> Void
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      HStack {
        VStack(alignment: .leading, spacing: 15) {
          VStack(alignment: .leading, spacing: 2) {
            Text(bannerType.title)
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(Resources.Fonts.medium(withSize: 20))
              .foregroundColor(.white)
            
            Text(bannerType.text)
              .lineLimit(2)
              .font(Resources.Fonts.regular(withSize: 15))
              .foregroundColor(.white)
          }
          Button {
            action()
          } label: {
            HStack(spacing: 3) {
              Text(bannerType.buttonText)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.medium(withSize: 15))
              Resources.Images.Navigation.chevronRight
                .resizable().frame(width: 18, height: 18)
                .foregroundColor(Resources.Colors.customBlack)
            }
            .padding([.vertical,.horizontal], 10)
            .background(.white)
            .cornerRadius(10)
          }
        }
      }
      .padding(.vertical, 15)
      .padding(.horizontal, 15)
      
      
      bannerType.image
        .resizable()
        .frame(width: 110, height: 110)
        .offset(x: 20, y: 35)
    }
    .background(Resources.Colors.primary)
    .cornerRadius(15)
    .padding([.leading,.trailing], 16)
  }
}

struct NYCPromoBanner_Previews: PreviewProvider {
  static var previews: some View {
    NYCPromoBanner(bannerType: .suggestLocation, action: {})
  }
}
