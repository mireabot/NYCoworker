//
//  AdminButtonCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/18/23.
//

import SwiftUI

struct AdminButtonCard: View {
  var type: CardType
  var body: some View {
    HStack(alignment: .center) {
      NYCCircleImageButton(size: 20, image: type.image,action: {})
      VStack(alignment: .leading, spacing: 2) {
        Text(type.title)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 15))
        Text(type.text)
          .foregroundColor(Resources.Colors.darkGrey)
          .font(Resources.Fonts.regular(withSize: 13))
      }
      .padding(.leading, 5)
    }
    .padding(10)
    .frame(maxWidth: .infinity, alignment: .leading)
    .cornerRadius(5)
    .padding([.leading,.trailing], 16)
  }
}

struct AdminButtonCard_Previews: PreviewProvider {
  static var previews: some View {
    AdminButtonCard(type: .manageLocations)
  }
}

extension AdminButtonCard { // MARK: - Enums
  enum CardType {
    case manageLocations
    case createReview
    case reviewModeration
    case sendNotifications
    
    var title: String {
      switch self {
      case .manageLocations: return "Manage locations"
      case .createReview: return "Create reviews"
      case .reviewModeration: return "Publish pending reviews"
      case .sendNotifications: return "Send remote notifications"
      }
    }
    
    var text: String {
      switch self {
      case .manageLocations: return "Add new locations to database"
      case .createReview: return "Write a demo review for location"
      case .reviewModeration: return "Check new reviews and publish them"
      case .sendNotifications: return "Create push notification for users"
      }
    }
    
    var image: Image {
      switch self {
      case .manageLocations: return Resources.Images.Onboarding.mark
      case .createReview: return Resources.Images.Settings.rate
      case .reviewModeration: return Resources.Images.Navigation.share
      case .sendNotifications: return Resources.Images.Settings.manageNotifications
      }
    }
  }
}
