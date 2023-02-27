//
//  ManageNotificationsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/27/23.
//

import SwiftUI

struct ManageNotificationsView: View {
    @State var isOn = true
    var body: some View {
        VStack {
            VStack(spacing: 25) {
                NYCNotificationCard(isOn: $isOn)
                NYCNotificationCard(isOn: $isOn)
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Update")
            }
            .buttonStyle(NYCActionButtonStyle())
            .padding([.leading,.trailing], 16)
            .padding(.bottom, 20)

        }
    }
}

struct ManageNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageNotificationsView()
    }
}
