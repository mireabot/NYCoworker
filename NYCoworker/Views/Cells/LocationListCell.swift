//
//  LocationListCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI

struct LocationListCell: View {
    enum CellType {
        case list
        case favorite
    }
    var type: CellType
    var buttonAction: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                Image("load")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .cornerRadius(10)
                
                HStack(alignment: .center) {
                    NYCRateBadge(rate: 5, badgeType: .card)
                    .offset(x: 6, y: 6)
                    Spacer()
                    Button {
                        buttonAction()
                    } label: {
                        Image(type == .list ? "add" : "close")
                            .resizable()
                            .foregroundColor(Resources.Colors.customBlack)
                            .frame(width: 20, height: 20)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(20)
                            .offset(x: -6, y: 6)
                    }
                }
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 3) {
                        NYCBadgeView(badgeType: .withWord, title: "New")
                        NYCBadgeView(badgeType: .withWord, title: "Popular")
                        NYCBadgeView(badgeType: .workingHours, title: "Open now")
                    }
                    Text("Public Hotel")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 20))
                    Text("691 Eight Avenue")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 13))
                }
                Spacer()
                Text("1,7 mi")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 15))
            }
        }
    }
}

//struct LocationListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationListCell(type: .list, buttonAction: ())
//    }
//}
