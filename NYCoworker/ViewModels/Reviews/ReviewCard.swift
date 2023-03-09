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
    var data: ReviewModel
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
