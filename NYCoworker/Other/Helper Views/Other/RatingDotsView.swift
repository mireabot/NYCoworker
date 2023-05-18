//
//  RatingDotsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/22/23.
//

import SwiftUI

struct RatingDotsView: View {
    var number: Int
    var body: some View {
        HStack(spacing: 5) {
          Resources.Images.Settings.like
            .resizable()
            .frame(width: 12, height: 12)
            .foregroundColor(Resources.Colors.primary)
            Text("\(number)")
                .foregroundColor(Resources.Colors.primary)
                .font(Resources.Fonts.regular(withSize: 12))
        }
    }
}

struct RatingDotsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingDotsView(number: 1)
    }
}
