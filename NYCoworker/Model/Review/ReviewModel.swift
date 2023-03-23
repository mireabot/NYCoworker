//
//  ReviewModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/9/23.
//

import SwiftUI

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
struct ReviewModel: Identifiable {
    var id: Int
    var userIcon: Image
    var userName: String
    var reviewType: String
    var datePosted: String
    var dateVisited: String
    var reviewText: String
}

let reviewData = [
    ReviewModel(id: 0, userIcon: Image("p3"), userName: "Saleb", reviewType: "positive", datePosted: "30 Jan 2023", dateVisited: "10 Jan 2023", reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."),
    ReviewModel(id: 1, userIcon: Image("p1"), userName: "Alex", reviewType: "positive", datePosted: "30 Jan 2023", dateVisited: "10 Jan 2023", reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."),
    ReviewModel(id: 2, userIcon: Image("p2"), userName: "May", reviewType: "positive", datePosted: "30 Jan 2023", dateVisited: "10 Jan 2023", reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."),
]
