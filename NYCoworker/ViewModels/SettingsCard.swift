//
//  SettingsCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/31/23.
//

import SwiftUI

struct SettingsCard: View {
    var data: SettingsModel
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                data.icon
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Resources.Colors.customBlack)
                Text(data.title)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 15))
            }
            
            Spacer()
            
            Resources.Images.Navigation.chevron
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Resources.Colors.darkGrey)
        }
        .padding(15)
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
    }
}

//struct SettingsCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsCard()
//    }
//}
