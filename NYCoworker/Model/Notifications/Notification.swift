//
//  NotificationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/28/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct Notification: Codable {
    let title: String
    let text: String
}


@MainActor
class NotificationModel: ObservableObject {
    @Published var notifications: [Notification] = []
    let notificationService: NotificationService
    
    init(notificationService: NotificationService) {
        self.notificationService = notificationService
    }
    
    func getAll() async throws {
        notificationService.getNotifications { notificationsData in
            self.notifications = notificationsData
        }
    }
}
