//
//  FavoriteLocationCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

struct FavoriteLocationCell: View {
    var body: some View {
        HStack(alignment: .center) {
            Rectangle()
                .frame(width: 110, height: 110)
                .cornerRadius(5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Public Hotel")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 17))
                
                Text("I had I was very sad this day. There were friendly people at the bar that engaged with me. Interactions with people was very well needed. I enjoyed a great Long Island ice tea,some tasty vegetarian nachos, and sat by the water")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Text("1,7 mi ·")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 12))
                    HStack(alignment: .center, spacing: 1) {
                        Image("rate")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(Resources.Colors.actionGreen)
                        Text("2")
                            .foregroundColor(Resources.Colors.actionGreen)
                            .font(Resources.Fonts.regular(withSize: 12))
                    }
                }
            }
        }
    }
}

struct FavoriteLocationCell_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteLocationCell()
    }
}
