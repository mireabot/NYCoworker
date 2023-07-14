//
//  AdminHomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/20/23.
//

import SwiftUI

struct AdminHomeView: View {
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 10) {
          NavigationLink(destination: AdminLocationView()) {
            AdminButtonCard(type: .manageLocations)
          }
          
          NavigationLink(destination: AdminNotificationView()) {
            AdminButtonCard(type: .sendNotifications)
          }
          
          NavigationLink(destination: AdminReviewsView()) {
            AdminButtonCard(type: .createReview)
          }
          
          NavigationLink(destination: AdminModerationView()) {
            AdminButtonCard(type: .reviewModeration)
          }
        }
      }
      .scrollDisabled(true)
      .toolbarBackground(.white, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCHeader(title: "Admin dashboard")
        }
      }
    }
  }
}

struct AdminHomeView_Previews: PreviewProvider {
  static var previews: some View {
    AdminHomeView()
  }
}
