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
    @State var isLoading = true
    @StateObject var notificationService = NotificationService()
    var body: some View {
        notificationsList()
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
                        .font(Resources.Fonts.medium(withSize: 17))
                }
            })
            .task {
                guard notificationService.notifications.isEmpty else { return }
                await notificationService.fetchNotifications(completion: {
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                })
            }
            .navigationBarBackButtonHidden()
            .toolbarBackground(.white, for: .navigationBar)
    }
    
    @ViewBuilder
    func notificationsList() -> some View {
        if isLoading {
            ProgressView()
        }
        else {
            if notificationService.notifications.isEmpty {
                emptyView()
            }
            else {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(spacing: 10) {
                        ForEach(notificationService.notifications, id: \.datePosted) { item in
                            NotificationCard(data: item)
                        }
                    }
                    .padding(.top, 10)
                }
            }
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
