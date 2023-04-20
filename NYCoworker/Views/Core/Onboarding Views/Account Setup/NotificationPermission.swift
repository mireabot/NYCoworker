//
//  NotificationPermission.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI
import UserNotifications
import PopupView
import FirebaseMessaging

struct NotificationPermission: View {
    @State var showAlert: Bool = false
    @AppStorage("fcmToken") var firebaseToken: String = ""
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
            requestNotificationPermissions()
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
    
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
                return
            }
            
            if granted {
                print("Notifications granted!")
                Messaging.messaging().token(completion: { token, error in
                    if let error = error {
                        print("Error getting FCM token: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let token = token else {
                        print("FCM token is nil")
                        return
                    }
                    
                    print("FCM token: \(token)")
                    firebaseToken = token
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                })
            } else {
                print("Notifications not granted")
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
