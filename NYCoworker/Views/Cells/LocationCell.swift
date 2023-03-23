//
//  LocationCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

/// Location cell viewModel
///
/// Used in home screen locations collection
///
///  - Parameters:
///    - data: Data about location taken from LocationModel
///    - type: Type of cell taken from enum LocationCellType / small or large
struct LocationCell: View {
    enum LocationCellType {
        case small
        case large
    }
    var data: LocationModel
    let type: LocationCellType?
    var body: some View {
        switch type {
        case .small:
            smallCard(withData: data)
        case .large:
            largeCard(withData: data)
        case .none:
            smallCard(withData: data)
        }
    }
}
/// Views constructors for location cells
///
/// Extension of LocationCell struct
extension LocationCell {
    /// ViewBuilder for large location card cell
    ///  - Parameters:
    ///     - data: Location data from LocationModel
    @ViewBuilder
    func largeCard(withData data: LocationModel) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            ZStack(alignment: .bottomLeading) {
                ZStack(alignment: .topTrailing) {
                    Image(data.images[0])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 100)
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
                HStack(spacing: 5) {
                    NYCBadgeView(badgeType: .withWord, title: "New")
                }
                .offset(x: 6, y: -6)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(data.name)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 15))
                    .lineLimit(0)
                HStack {
                    Text(data.distance)
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 12))
                    RatingDotsView(number: data.reviewsNumber)
                }
            }
        }
    }
    /// ViewBuilder for small location card cell
    ///  - Parameters:
    ///     - data: Location data from LocationModel
    @ViewBuilder
    func smallCard(withData data: LocationModel) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            ZStack(alignment: .topTrailing) {
                Image(data.images[0])
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
            
            Text(data.name)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 13))
                .lineLimit(0)
            
            HStack(spacing: 4) {
                Text("\(data.distance) ·")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
                RatingDotsView(number: data.reviewsNumber)
            }
        }
        .frame(width: 120)
    }
}


//struct LocationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationCellLarge()
//    }
//}
