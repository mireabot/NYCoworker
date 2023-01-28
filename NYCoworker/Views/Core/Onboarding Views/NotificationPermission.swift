//
//  NotificationPermission.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI
import UserNotifications

struct NotificationPermission: View {
    @State var prepareToNavigate: Bool = false
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
            
            NYCActionButton(action: {
                requestNotification()
            }, text: "Continue")
            .padding(.bottom, 10)
        }
        .toolbar(.hidden)
        .navigationDestination(isPresented: $prepareToNavigate) {
            GeopositionPermission()
        }
    }
    
    func requestNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            if granted {
                prepareToNavigate.toggle()
            }
            else {
                print(error ?? "Unknown")
            }
        }
    }
}

struct NotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermission()
    }
}
