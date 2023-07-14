//
//  NotificationsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/16/23.
//

import SwiftUI
import PopupView

struct NotificationsView: View {
  @State var isLoading = false
  @EnvironmentObject var notificationService : NotificationService
  @EnvironmentObject var navigationState: NavigationDestinations
  var body: some View {
    notificationsList()
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            dismiss()
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
      .navigationBarBackButtonHidden()
      .toolbarBackground(.white, for: .navigationBar)
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
      if notificationService.notifications.isEmpty {
        NYCEmptyView(type: .notifications)
      }
      else {
        ScrollView(.vertical, showsIndicators: true) {
          LazyVStack(spacing: 10) {
            ForEach(notificationService.notifications, id: \.datePosted) { item in
              NotificationCard(data: item)
            }
          }
          .padding(.top, 10)
        }
      }
    }
  }
}

extension NotificationsView { //MARK: - Functions
  func dismiss() {
    navigationState.isPresentingNotifications = false
  }
}
