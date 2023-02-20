//
//  LocationMapCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI

struct LocationMapCard: View {
    var body: some View {
        HStack(alignment: .top) {
            Rectangle()
                .frame(width: 100, height: 100)
                .cornerRadius(10, corners: [.bottomLeft,.topLeft])
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    NYCBadgeView(badgeType: .withWord, title: "Library")
                    Text("Intelligentsia Coffee")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 17))
                    Text("691 Eight Avenue")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 13))
                }
                .padding(.top, 5)
                
                Button {
                    
                } label: {
                    Image("rate")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Resources.Colors.customBlack)
                }
                .padding(.top, 5)
                .padding(.leading, 25)
                .padding(.trailing, 5)
            }

        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct LocationMapCard_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapCard()
    }
}
