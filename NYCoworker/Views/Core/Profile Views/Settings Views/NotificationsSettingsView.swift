//
//  ManageNotificationsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/27/23.
//

import SwiftUI

struct NotificationsSettingsView: View {
    @State var isOn = true
    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 25) {
                    NYCNotificationCard(isOn: $isOn)
                    NYCNotificationCard(isOn: $isOn)
                }
                .padding(.top, 20)
                
                Button {
                    
                } label: {
                    Text("Update")
                }
                .disabled(true)
                .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
                .padding([.leading,.trailing], 16)
                .padding(.top, 40)
                Spacer()
            }
        }
    }
}

struct ManageNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsSettingsView()
    }
}
