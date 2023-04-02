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
    var avatarURL: String
    var name: String
    var occupation: String
    var favoriteLocations: [String]
    
    static var empty = User(userID: "", avatarURL: "", name: "", occupation: "", favoriteLocations: [])
}
