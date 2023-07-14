//
//  NotificationService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/28/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class NotificationService: ObservableObject {
  private var db = Firestore.firestore()
  @Published var notifications: [Notification] = []
  
  /// Fetching notifications from database sorted by date posted
  ///- returns: set of notifications
  func fetchNotifications(completion: @escaping () -> Void) async {
    do {
      var query: Query!
      query = db.collection(Endpoints.notifications.rawValue).order(by: "datePosted", descending: true)
      let docs = try await query.getDocuments()
      let notificationsFetched = docs.documents.compactMap { doc -> Notification? in
        try? doc.data(as: Notification.self)
      }
      await MainActor.run(body: {
        notifications = notificationsFetched
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
  
  ///Create notification
  ///- Parameters:
  ///   - notification: Template of notification object to send
  func createNotification(from notification: Notification, completion: @escaping () -> Void) async {
    do {
      let notificationData = try Firestore.Encoder().encode(notification)
      try await db.collection(Endpoints.notifications.rawValue).document().setData(notificationData)
      await MainActor.run(body: {
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
}
