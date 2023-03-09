//
//  ReviewModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/9/23.
//

import SwiftUI

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
