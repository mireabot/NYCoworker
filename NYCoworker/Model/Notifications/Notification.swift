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
    var title: String
    var text: String
    @ServerTimestamp var datePosted: Timestamp?
}
