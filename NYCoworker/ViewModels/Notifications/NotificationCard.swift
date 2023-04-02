//
//  NotificationCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/7/23.
//

import SwiftUI

struct NotificationCard: View {
    var data: Notification
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        Text(data.title)
                            .foregroundColor(Resources.Colors.customBlack)
                            .font(Resources.Fonts.bold(withSize: 17))
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Resources.Colors.primary)
                    }
                    Text(data.text)
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 15))
                    Text(data.datePosted?.dateValue() ?? Date(), style: .date)
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 13))
                        .padding(.top, 10)
                }
                
                Spacer()
            }
            
            Rectangle()
                .fill(Resources.Colors.customGrey)
                .frame(height: 1)
        }
        .padding([.leading,.trailing], 16)
    }
}

//struct NotificationCard_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationCard()
//    }
//}
