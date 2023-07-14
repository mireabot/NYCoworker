//
//  AdminNotificationView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 7/14/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AdminNotificationView: View {
  @Environment(\.dismiss) var makeDismiss
  @State private var notificationTitle: String = ""
  @State private var notificationText: String = ""
  @StateObject private var notificationService = NotificationService()
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(spacing: 20) {
        NYCTextField(title: "Enter title", placeholder: "Notification title", text: $notificationTitle)
        NYCTextField(title: "Enter text", placeholder: "Notification text", text: $notificationText)
      }.padding([.leading,.trailing], 16)
    }
    .navigationBarBackButtonHidden()
    .toolbarBackground(.white, for: .navigationBar)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          makeDismiss()
        } label: {
          Resources.Images.Navigation.arrowBack
            .foregroundColor(Resources.Colors.primary)
        }
        
      }
      
      ToolbarItem(placement: .navigationBarLeading) {
        Text("Add notification")
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 17))
      }
      
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          saveNotification()
        } label: {
          Text("Submit")
            .foregroundColor(Resources.Colors.primary)
        }
      }
    }
  }
}

struct AdminNotificationView_Previews: PreviewProvider {
  static var previews: some View {
    AdminReviewsView()
  }
}

extension AdminNotificationView { // MARK: - Functions
  func saveNotification() {
    let notification = Notification(
      title: notificationTitle,
      text: notificationText,
      datePosted:Timestamp(date: .now))
    Task {
      await notificationService.createNotification(from: notification) {
        notificationTitle = ""
        notificationText = ""
        makeDismiss()
      }
    }
  }
}
