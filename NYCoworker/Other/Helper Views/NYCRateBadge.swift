//
//  NYCRateBadge.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI

struct NYCRateBadge: View {
    var rate: Int
    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            Image("rate")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(Resources.Colors.actionGreen)
            Text("\(rate)")
                .foregroundColor(Resources.Colors.actionGreen)
                .font(Resources.Fonts.regular(withSize: 12))
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(5)
    }
}

struct NYCRateBadge_Previews: PreviewProvider {
    static var previews: some View {
        NYCRateBadge(rate: 5)
    }
}
