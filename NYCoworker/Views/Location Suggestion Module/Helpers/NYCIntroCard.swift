//
//  NYCIntroCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/9/23.
//

import SwiftUI

struct NYCIntroCard: View {
  let type: CardType
    var body: some View {
      HStack(alignment: .top, spacing: 15) {
        type.icon
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(Resources.Colors.primary)
        VStack(alignment: .leading, spacing: 5) {
          Text(type.title)
            .font(Resources.Fonts.medium(withSize: 16))
            .foregroundColor(Resources.Colors.customBlack)
          Text(type.text)
            .font(Resources.Fonts.regular(withSize: 15))
            .foregroundColor(Resources.Colors.darkGrey)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding([.vertical,.horizontal], 15)
      .background(Resources.Colors.customGrey)
      .cornerRadius(16)
    }
}

struct NYCIntroCard_Previews: PreviewProvider {
    static var previews: some View {
      NYCIntroCard(type: .business).padding([.leading,.trailing], 16)
    }
}

extension NYCIntroCard {
  enum CardType {
    case business
    case coworker
    
    var title: String {
      switch self {
      case .business: return "If you’re business owner"
      case .coworker: return "If you’re coworker"
      }
    }
    
    var text: String {
      switch self {
      case .business: return "More clients and recognition along coworkers"
      case .coworker: return "Meet and collaborate with fresh peers in your special work spot"
      }
    }
    
    var icon: Image {
      switch self {
      case .business: return Resources.Images.Onboarding.business
      case .coworker: return Resources.Images.Onboarding.coworker
      }
    }
  }
}
