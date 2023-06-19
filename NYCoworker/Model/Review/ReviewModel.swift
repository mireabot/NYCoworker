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
///    - isLive: is review open to public
///    - userToken: messaging token to send push notification
///
/// - Returns: ReviewModel struct object with parameters

struct Review: Identifiable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var locationID: String
  @ServerTimestamp var datePosted: Timestamp?
  @ServerTimestamp var dateVisited: Timestamp?
  var text: String
  var type: ReviewType
  var userName: String
  var userImage: URL
  var isLive: Bool
  var userToken: String
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
  
  static let mock = Review(id: "", locationID: "", datePosted: Timestamp(date: Date()), dateVisited: Timestamp(date: Date()), text: "Mock text", type: .pos, userName: "User name", userImage: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/nycoworker-10d04.appspot.com/o/UserImages%2Fc9xFqsSNUIewbF6iaujJ5gdf3Vs2?alt=media&token=1cf23bfe-e4db-4542-816b-0e23a83f1755")!, isLive: true, userToken: "")
}
