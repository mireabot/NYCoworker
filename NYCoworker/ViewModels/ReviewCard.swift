//
//  ReviewCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/14/23.
//

import SwiftUI

struct ReviewCard: View {
    enum ReviewCardType {
        case full
        case small
    }
    var variation: ReviewCardType
    var data: ReviewData
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            /// Header
            HStack(alignment: .center, spacing: 10) {
                data.userIcon
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(data.userName)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 17))
                Image("review-pos")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Resources.Colors.actionGreen)
            }
            /// Review info
            HStack {
                Text("Posted \(data.datePosted) · Visited \(data.dateVisited)")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
            }
            /// Review text
            HStack {
                Text(data.reviewText)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 13))
                    .lineLimit(variation == .full ? 20 : 3)
            }
        }
        .padding(16)
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
        
    }
}

//struct ReviewCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewCard(variation: .full)
//    }
//}

struct ReviewData: Identifiable {
    var id: Int
    var userIcon: Image
    var userName: String
    var reviewType: String
    var datePosted: String
    var dateVisited: String
    var reviewText: String
}

let reviewData = [
    ReviewData(id: 0, userIcon: Image("p3"), userName: "Saleb", reviewType: "positive", datePosted: "30 Jan 2023", dateVisited: "10 Jan 2023", reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."),
    ReviewData(id: 1, userIcon: Image("p1"), userName: "Alex", reviewType: "positive", datePosted: "30 Jan 2023", dateVisited: "10 Jan 2023", reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."),
    ReviewData(id: 2, userIcon: Image("p2"), userName: "May", reviewType: "positive", datePosted: "30 Jan 2023", dateVisited: "10 Jan 2023", reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."),
]
