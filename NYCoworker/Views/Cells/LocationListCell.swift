//
//  LocationListCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI

/// Location cell for list views / favorites and detail list by location category
///
///  - Parameters:
///    - type: Type of cell taken from enum CellType
///    - data: Data about location taken from LocationModel
///    - buttonAction: Action from button inside cell -> passes func to root view
struct LocationListCell: View {
    /// Enum defines cell type
    ///
    ///  - Parameters:
    ///     - list: Used in detailed view when showed all locations of exact type · Adds action button for cell
    ///     - favorite: Used in list of favorite location · Hides action button
    enum CellType {
        case list
        case favorite
    }
    var type: CellType
    var data: LocationModel
    var buttonAction: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                Image(data.images[0])
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
                        Image("add")
                            .resizable()
                            .foregroundColor(Resources.Colors.customBlack)
                            .frame(width: 20, height: 20)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(20)
                            .offset(x: -6, y: 6)
                    }.opacity(type == .list ? 1 : 0)
                }
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 3) {
                        NYCBadgeView(badgeType: .withWord, title: "New")
                        NYCBadgeView(badgeType: .withWord, title: "Popular")
                    }
                    Text(data.name)
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 20))
                    Text(data.address)
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 13))
                }
                Spacer()
                Text("\(data.distance)")
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
