//
//  ReviewModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/9/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

/// Data model for reviews about locations
///
/// Stored in Firebase storage and can be called by location id ref
///
///  - Parameters:
///    - id: ID of review
///    - userIcon: icon of user who made review
///    - userName: name of user who made review
///    - reviewType: type of review / can be positive of negative
///    - datePosted: timestamp when review was posted to database
///    - dateVisited: timestamp when user viisited location
///    - reviewText: text of review
///
/// - Returns: ReviewModel struct object with parameters

struct Review: Codable {
    var id: String
    @ServerTimestamp var datePosted: Timestamp?
    @ServerTimestamp var dateVisited: Timestamp?
    var text: String
    var type: ReviewType
    var userName: String
    var userImage: URL
    var datePostedString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: datePosted?.dateValue() ?? Date())
    }
    var dateVisitedString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: dateVisited?.dateValue() ?? Date())
    }
    
    enum ReviewType: String, Codable {
        case pos = "positive"
        case neg = "negative"
    }
}
