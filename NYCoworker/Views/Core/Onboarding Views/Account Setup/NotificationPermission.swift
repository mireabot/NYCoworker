//
//  NotificationPermission.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI
import UserNotifications
import PopupView

struct NotificationPermission: View {
    @State var showAlert: Bool = false
    var body: some View {
        VStack {
            /// Content stack
            HStack {
                VStack(alignment: .leading) {
                    Image("notification")
                        .resizable()
                        .frame(width: 70, height: 70)
                    
                    Text("Get updates on the newest locations and updates")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 34))
                }
                
                Spacer()
            }
            .padding([.leading,.trailing], 16)
            .padding(.top, 30)
            
            Spacer()
        }
        .addTransition()
        .onAppear {
            requestNotification()
        }
        .popup(isPresented: $showAlert) {
            NYCAlertView(type: .notification) {
                showAlert.toggle()
            }
        } customize: {
            $0
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        }
    }
    
    func requestNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            if granted {
                print("Access granted")
            }
            else {
                print(error ?? "Unknown")
                showAlert.toggle()
            }
        }
    }
}

struct NotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermission()
    }
}
