//
//  LoadingLocationCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/2/23.
//

import SwiftUI

struct LoadingLocationCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .topTrailing) {
                Image("sample")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 100)
                    .cornerRadius(15)
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
                ForEach(0..<2) { title in
                    NYCBadgeView(badgeType: .withWord, title: "title")
                }
            }
            
            Text("Name")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 13))
                .lineLimit(0)
            
            HStack(spacing: 4) {
                Text("2 mi ·")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
                RatingDotsView(number: 1)
            }
        }
        .frame(width: 180)
    }
}
