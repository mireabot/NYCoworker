//
//  NotificationsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/16/23.
//

import SwiftUI
import PopupView

struct NotificationsView: View {
    @Environment(\.dismiss) var makeDismiss
    var body: some View {
        notificationsList()
            .hideTabbar(shouldHideTabbar: true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        makeDismiss()
                    } label: {
                        Resources.Images.Navigation.arrowBack
                            .foregroundColor(Resources.Colors.primary)
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Notifications")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 17))
                }
            })
        
            .navigationBarBackButtonHidden()
            .toolbarBackground(.white, for: .navigationBar)
    }
    
    @ViewBuilder
    func notificationsList() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 10) {
                ForEach(0..<4) { item in
                    NotificationCard()
                }
            }
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    func emptyView() -> some View {
        VStack {
            NotificationsEmptyView()
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
