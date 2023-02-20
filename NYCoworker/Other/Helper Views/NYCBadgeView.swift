//
//  NYCBadgeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

struct NYCBadgeView: View {
    enum BadgeStyle {
        case withWord
        case workingHours
        case location
    }
    var badgeType: BadgeStyle
    var title: String
    var body: some View {
        switch badgeType {
        case .withWord:
            badgeWithTitle
        case .workingHours:
            badgeWithIcon
        case .location:
            badgeWithTitle
        }
    }
    var badgeWithTitle: some View {
        Text(title)
            .foregroundColor(Resources.Colors.primary)
            .font(Resources.Fonts.regular(withSize: 10))
            .padding([.top,.bottom], 2)
            .padding([.leading,.trailing], 5)
            .background(Resources.Colors.customGrey)
            .cornerRadius(5)
    }
    var badgeWithIcon: some View {
        HStack(spacing: 3) {
            Image("time")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(Resources.Colors.primary)
            Text(title)
                .foregroundColor(Resources.Colors.primary)
                .font(Resources.Fonts.regular(withSize: 10))
            
        }
            .padding([.top,.bottom], 2)
            .padding([.leading,.trailing], 5)
            .background(Resources.Colors.customGrey)
            .cornerRadius(5)
    }
}

//struct NYCBadgeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCBadgeWithIconView(title: "Open now")
//    }
//}
