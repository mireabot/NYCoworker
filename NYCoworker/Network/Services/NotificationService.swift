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
    
    /// Fetching notifications from database
    /// Sorted by date posted
    ///  - Returns:
    ///  - completion - any action
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
}
