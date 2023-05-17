//
//  NotificationsEmptyView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/19/23.
//

import SwiftUI

struct NotificationsEmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("notificationsEmpty")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            VStack(alignment: .center, spacing: 10) {
                Text("No new notifications")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.medium(withSize: 20))
                Text("Here you can see latest app news and coworkers posts")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .multilineTextAlignment(.center)
                    .font(Resources.Fonts.regular(withSize: 17))
            }
        }
        .padding([.leading,.trailing], 16)
    }
}

struct NotificationsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsEmptyView()
    }
}
