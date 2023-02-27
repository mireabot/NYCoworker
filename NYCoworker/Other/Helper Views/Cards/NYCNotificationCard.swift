//
//  NYCNotificationCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/25/23.
//

import SwiftUI

struct NYCNotificationCard: View {
    @Binding var isOn : Bool
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                Text("General notifications")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 17))
                Text("You will receive notifications about \nnew spaces, coworker updates and more")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 15))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(isOn ? "checkmark-selected" : "checkmark")
                    .resizable()
                    .frame(width: 30, height: 30)
            }

            
        }
        .padding([.leading,.trailing], 16)
    }
}

//struct NYCNotificationCard_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCNotificationCard(isOn: <#Binding<Bool>#>)
//    }
//}
