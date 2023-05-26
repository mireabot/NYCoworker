//
//  User.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/1/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct User: Codable {
    var userID: String
    var avatarURL: URL
    var name: String
    var occupation: String
    var favoriteLocations: [String]
  var token: String
}
