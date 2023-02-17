//
//  AmenityCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/16/23.
//

import SwiftUI

struct AmenityCard: View {
    var data: AmenityModel
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            data.icon
                .resizable()
                .frame(width: 24, height: 24)
            Text(data.title)
                .foregroundColor(Resources.Colors.darkGrey)
                .font(Resources.Fonts.regular(withSize: 15))
        }
        .padding(2)
    }
}

//struct AmenityCard_Previews: PreviewProvider {
//    static var previews: some View {
////        AmenityCard(data: amenityData[0])
//        WorkingHoursCard(data: hoursData[5])
//    }
//}
//

struct WorkingHoursCard: View {
    var data: WorkingHoursModel
    var body: some View {
        VStack(spacing: 5) {
            Text(data.day)
                .foregroundColor(Resources.Colors.darkGrey)
                .font(Resources.Fonts.regular(withSize: 15))
            Text(data.hours)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 15))
        }
        .padding(10)
        .background(Resources.Colors.customGrey)
        .cornerRadius(5)
    }
}
