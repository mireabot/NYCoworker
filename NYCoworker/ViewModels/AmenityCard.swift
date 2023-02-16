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
//        .background(Resources.Colors.customGrey)
//        .cornerRadius(5)
    }
}

struct AmenityCard_Previews: PreviewProvider {
    static var previews: some View {
        AmenityCard(data: amenityData[0])
    }
}
