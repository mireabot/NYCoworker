//
//  NYCRateBadge.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI

struct NYCRateBadge: View {
    enum RateBadgeStyle {
        case card
        case expanded
    }
    enum ReviewType {
        case postive
        case negative
    }
    var rate: Int?
    var badgeType: RateBadgeStyle
    var reviewType: ReviewType?
    var body: some View {
        switch badgeType {
        case .card:
            cardRateBadge
        case .expanded:
            expandedRateBadge
        }
    }
    
    var cardRateBadge: some View {
        HStack(alignment: .center, spacing: 1) {
          Resources.Images.Settings.like
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(Resources.Colors.actionGreen)
            Text("\(rate ?? 0)")
                .foregroundColor(Resources.Colors.actionGreen)
                .font(Resources.Fonts.regular(withSize: 12))
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(5)
    }
    var expandedRateBadge: some View {
        HStack(alignment: .center, spacing: 3) {
            Image(reviewType == .postive ? "review-pos" : "review-neg")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(reviewType == .postive ? Resources.Colors.actionGreen : Resources.Colors.actionRed)
            Text(reviewType == .postive ? "Positive" : "Negative")
                .foregroundColor(reviewType == .postive ? Resources.Colors.actionGreen : Resources.Colors.actionRed)
                .font(Resources.Fonts.regular(withSize: 12))
        }
        .padding([.top,.bottom], 2)
        .padding([.leading,.trailing], 5)
        .background(Resources.Colors.customGrey)
        .cornerRadius(5)
    }
}

struct NYCRateBadge_Previews: PreviewProvider {
    static var previews: some View {
        NYCRateBadge(rate: 5, badgeType: .expanded, reviewType: .postive)
    }
}
