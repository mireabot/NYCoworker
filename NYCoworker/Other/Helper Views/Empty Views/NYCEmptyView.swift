//
//  NYCEmptyView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 7/11/23.
//

import SwiftUI

struct NYCEmptyView: View {
  var type: ViewType
  var body: some View {
    viewType(type)
  }
}

struct NYCEmptyView_Previews: PreviewProvider {
  static var previews: some View {
    NYCEmptyView(type: .moderationReviews)
  }
}

extension NYCEmptyView { // MARK: - Enum
  enum ViewType {
    case favorites
    case notifications
    case moderationReviews
    case noReviews
    case noAmenities
    case noWorkingHours
  }
}

extension NYCEmptyView { // MARK: - Functions
  @ViewBuilder
  func viewType(_ type: NYCEmptyView.ViewType) -> some View {
    switch type {
    case .favorites:
      favoritesEmptyView()
    case .notifications:
      notificationsEmptyView()
    case .moderationReviews:
      moderationReviewsEmptyView()
    case .noReviews:
      noReviewsView()
    case .noAmenities:
      noAmenitiesView()
    case .noWorkingHours:
      noWorkingHoursView()
    }
  }
}

extension NYCEmptyView { // MARK: - Views
  @ViewBuilder
  func favoritesEmptyView() -> some View {
    VStack(alignment: .center) {
      Image("favoritesEmpty")
        .resizable()
        .frame(width: 100, height: 100)
        .padding(.bottom, 20)
      
      VStack(alignment: .center, spacing: 10) {
        Text("Add locations to favorites")
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 20))
        Text("Once you add any locations to favorites, you can see it here")
          .foregroundColor(Resources.Colors.darkGrey)
          .multilineTextAlignment(.center)
          .font(Resources.Fonts.regular(withSize: 17))
      }
    }
    .padding([.leading,.trailing], 16)
  }
  
  @ViewBuilder
  func notificationsEmptyView() -> some View {
    VStack(alignment: .center) {
      Image("notificationsEmpty")
        .resizable()
        .frame(width: 100, height: 100)
        .padding(.bottom, 20)
      
      VStack(alignment: .center, spacing: 10) {
        Text("No new notifications")
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 20))
        Text("Here you can see latest app news and coworkers posts")
          .foregroundColor(Resources.Colors.darkGrey)
          .multilineTextAlignment(.center)
          .font(Resources.Fonts.regular(withSize: 17))
      }
    }
    .padding([.leading,.trailing], 16)
  }
  
  @ViewBuilder
  func moderationReviewsEmptyView() -> some View {
    VStack(alignment: .center) {
      Image("favoritesEmpty")
        .resizable()
        .frame(width: 100, height: 100)
        .padding(.bottom, 20)
      
      VStack(alignment: .center, spacing: 10) {
        Text("No new reviews for moderation")
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 20))
      }
    }
    .padding([.leading,.trailing], 16)
  }
  
  @ViewBuilder
  func noReviewsView() -> some View {
    VStack {
      Text("No reviews so far")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 17))
    }
    .frame(maxWidth: .infinity)
    .padding(16)
    .background(Resources.Colors.customGrey)
    .cornerRadius(15)
  }
  
  @ViewBuilder
  func noAmenitiesView() -> some View {
    VStack {
      Text("No data so far")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 17))
    }
    .frame(maxWidth: .infinity)
    .padding(16)
    .background(Resources.Colors.customGrey)
    .cornerRadius(15)
  }
  
  @ViewBuilder
  func noWorkingHoursView() -> some View {
    VStack {
      Text("No data so far")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 17))
    }
    .frame(maxWidth: .infinity)
    .padding(16)
    .background(Resources.Colors.customGrey)
    .cornerRadius(15)
  }
}
