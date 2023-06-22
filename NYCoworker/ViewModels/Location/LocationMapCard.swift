//
//  LocationMapCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct LocationMapCard: View {
  let location: Location
  var buttonAction: () -> Void
  var body: some View {
    ZStack(alignment: .bottom) {
      ZStack(alignment: .topTrailing) {
        WebImage(url: location.locationImages[0]).placeholder {
          Image("load")
            .resizable()
        }
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 200)
        
        
        NYCCircleImageButton(size: 20, image: Resources.Images.Settings.rate, action: {
          buttonAction()
        })
        .padding([.top,.trailing], 10)
      }
      
      VStack(alignment: .leading, spacing: 2) {
        Text(location.locationName)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.regular(withSize: 20))
          .frame(maxWidth: .infinity,alignment: .leading)
          .lineLimit(1)
        Text(location.locationAddress)
          .foregroundColor(Resources.Colors.darkGrey)
          .font(Resources.Fonts.regular(withSize: 15))
      }
      .padding([.top,.bottom], 10)
      .padding([.leading,.trailing], 10)
      .background(Color.white)
      .clipped()
      .overlay(alignment: .topLeading) {
        HStack(spacing: 5) {
          NYCBadgeView(badgeType: .location, title: location.locationType.rawValue)
          Spacer()
          NYCRateBadge(rate: location.reviews, badgeType: .card)
        }
        .offset(y: -15)
        .padding([.leading,.trailing], 10)
      }
    }
    .cornerRadius(10)
    .padding([.leading,.trailing], 16)
  }
}

//struct LocationMapCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack(alignment: .bottom) {
//            Color.blue.edgesIgnoringSafeArea(.all)
//
//            LocationMapCard()
//        }
//    }
//}
//


//HStack(alignment: .top) {
//    Rectangle()
//        .frame(width: 100, height: 100)
//        .cornerRadius(10, corners: [.bottomLeft,.topLeft])
//    HStack(alignment: .top) {
//        VStack(alignment: .leading, spacing: 2) {
//            NYCBadgeView(badgeType: .withWord, title: "Library")
//            Text("Intelligentsia Coffee")
//                .foregroundColor(Resources.Colors.customBlack)
//                .font(Resources.Fonts.regular(withSize: 17))
//            Text("691 Eight Avenue")
//                .foregroundColor(Resources.Colors.darkGrey)
//                .font(Resources.Fonts.regular(withSize: 13))
//        }
//        .padding(.top, 5)
//
//        Button {
//
//        } label: {
//            Image("rate")
//                .resizable()
//                .frame(width: 18, height: 18)
//                .foregroundColor(Resources.Colors.customBlack)
//        }
//        .padding(.top, 5)
//        .padding(.leading, 25)
//        .padding(.trailing, 5)
//    }
//
//}
//.background(Color.white)
//.cornerRadius(10)
