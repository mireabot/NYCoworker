//
//  LanguageCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/26/23.
//

import SwiftUI

struct LanguageCard: View {
    var data: AppLanguageModel
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                data.flag
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text(data.language)
                    .font(Resources.Fonts.regular(withSize: 16))
                    .foregroundColor(Resources.Colors.customBlack)
            }
            
            Spacer()
        }
        .padding([.leading,.trailing], 16)
    }
}

struct LanguageCard_Previews: PreviewProvider {
    static var previews: some View {
        LanguageCard(data: appLanguages[0])
    }
}
