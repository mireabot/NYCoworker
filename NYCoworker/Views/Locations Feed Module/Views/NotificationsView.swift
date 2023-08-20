//
//  NotificationsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/16/23.
//

import SwiftUI

struct NotificationsView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  @EnvironmentObject var notificationStore: NotificationStore
  @State var isLoading = false
  var body: some View {
    NavigationView {
      notificationsList()
        .toolbar(content: {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              router.nav?.popViewController(animated: true)
            } label: {
              Resources.Images.Navigation.arrowBack
                .foregroundColor(Resources.Colors.primary)
            }
          }
          
          ToolbarItem(placement: .navigationBarLeading) {
            Text("Notifications")
              .foregroundColor(Resources.Colors.customBlack)
              .font(Resources.Fonts.medium(withSize: 17))
          }
        })
    }
  }
}

struct NotificationsView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationsView()
  }
}

extension NotificationsView { //MARK: - View components
  @ViewBuilder
  func notificationsList() -> some View {
    if isLoading {
      ProgressView()
    }
    else {
      if notificationStore.notifications.isEmpty {
        NYCEmptyView(type: .notifications)
      }
      else {
        ScrollView(.vertical, showsIndicators: true) {
          LazyVStack(spacing: 10) {
            ForEach(notificationStore.notifications, id: \.datePosted) { item in
              NotificationCard(data: item)
            }
          }
          .padding(.top, 10)
        }
      }
    }
  }
}
