//
//  ReviewCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/14/23.
//

import SwiftUI

struct ReviewCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            /// Header
            HStack(alignment: .center, spacing: 10) {
                Image("p1")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Saleb")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 17))
                Image("review-pos")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Resources.Colors.actionGreen)
            }
            /// Review info
            HStack {
                Text("Posted 30 Jan 2023 · Visited 10 Jan 2023")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
            }
            /// Review text
            HStack {
                Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 13))
                    .lineLimit(3)
            }
        }
        .padding(16)
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
        
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCard()
    }
}
