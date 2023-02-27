//
//  NYCLanguageCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/27/23.
//

import SwiftUI

struct NYCLanguageCard: View {
    @State var isOn : Bool = true
    var title: String
    var icon: Image
    var body: some View {
        HStack(alignment: .center) {
            HStack(spacing: 5) {
                icon
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(title)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 15))
            }
            
            Spacer()
            
            Image(isOn ? "checkmark-selected" : "checkmark")
                .resizable()
                .frame(width: 24, height: 24)

        }
        .padding([.leading,.trailing], 16)
    }
}

//struct NYCLanguageCard_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCLanguageCard()
//    }
//}
