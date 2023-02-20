//
//  LocationCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

struct LocationCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .topTrailing) {
                Image("load")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 100)
                    .cornerRadius(10)
                Button {
                    print("Button tapped")
                } label: {
                    Image("add")
                        .resizable()
                        .foregroundColor(Resources.Colors.customBlack)
                        .frame(width: 15, height: 15)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(15)
                        .offset(x: -6, y: 6)
                }

            }
            
            HStack(spacing: 3) {
                NYCBadgeView(badgeType: .withWord, title: "New")
            }
            
            Text("Public Hotel Hotel")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 13))
                .lineLimit(0)
            
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
        .frame(width: 120)
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell()
    }
}
