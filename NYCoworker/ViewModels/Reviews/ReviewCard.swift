//
//  ReviewCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/14/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewCard: View {
    enum ReviewCardType {
        case full
        case small
    }
    var variation: ReviewCardType
    var data: Review
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            /// Header
            HStack(alignment: .center, spacing: 10) {
                WebImage(url: data.userImage).placeholder {
                    Image("emptyImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
              
                Text(data.userName)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 17))
              NYCReviewTypeBadge(type: data.type)
            }
            /// Review info
            HStack {
                Text("Posted \(data.datePostedString) · Visited \(data.dateVisitedString)")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
            }
            /// Review text
            HStack {
                Text(data.text)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 13))
                    .lineLimit(variation == .full ? 20 : 3)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
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
