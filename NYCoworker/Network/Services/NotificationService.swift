//
//  NotificationService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/28/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class NotificationService {
    private var db = Firestore.firestore()
    
    func getNotifications(completion: @escaping ([Notification]) -> Void) {
        db.collection("Notifications").getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error retrieving notifications: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            var notifications = [Notification]()
            for document in documents {
                let data = document.data()
                guard let jsonData = try? JSONSerialization.data(withJSONObject: data),
                      let notification = try? JSONDecoder().decode(Notification.self, from: jsonData) else {
                    print("Error parsing notification data for document \(document.documentID)")
                    continue
                }
                
                notifications.append(notification)
            }
            
            completion(notifications)
        }
    }
}
