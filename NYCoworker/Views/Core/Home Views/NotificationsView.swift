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
        NavigationStack {
            VStack {
                NotificationsEmptyView()
            }
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
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
