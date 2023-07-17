//
//  NYCPromoBanner.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/6/23.
//

import SwiftUI

enum BannerType {
  case summerLocations
}

struct NYCPromoBanner: View {
  var bannerType: BannerType
  var action: () -> Void
  var body: some View {
    switch bannerType {
    case .summerLocations:
      summerLocations()
    }
  }
  
  @ViewBuilder
  func summerLocations() -> some View {
    ZStack(alignment: .bottomTrailing) {
      HStack {
        VStack(alignment: .leading, spacing: 10) {
          Text("Discover Refreshing Summer Spots: With Ice and Relax")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(Resources.Fonts.medium(withSize: 17))
            .foregroundColor(.white)
          Button {
            action()
          } label: {
            HStack(spacing: 3) {
              Text("Explore")
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
      .padding(.vertical, 10)
      .padding(.horizontal, 10)
      .background(Resources.Colors.primary)
      .cornerRadius(15)
      
      Image("sun")
        .resizable()
        .frame(width: 110, height: 110)
        .offset(x: 25, y: 35)
    }
    .clipped()
    .padding([.leading,.trailing], 16)
  }
}

struct NYCPromoBanner_Previews: PreviewProvider {
  static var previews: some View {
    NYCPromoBanner(bannerType: .summerLocations, action: {})
  }
}
