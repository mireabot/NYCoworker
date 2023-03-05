//
//  NYCSetupCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/3/23.
//

import SwiftUI

struct NYCSetupCard: View {
    enum NYCSetupCardType {
        case selected
        case unselected
    }
    var title: String
    var cardType: NYCSetupCardType
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 17))
            Spacer()
        }
        .padding([.leading,.trailing], 16)
        .padding([.top,.bottom], 20)
        .background(cardType == .selected ? Color.white : Resources.Colors.customGrey)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Resources.Colors.primary, lineWidth: cardType == .selected ? 1 : 0)
        }
    }
}

struct NYCSetupCard_Previews: PreviewProvider {
    static var previews: some View {
        NYCSetupCard(title: "Hello", cardType: .unselected)
    }
}
