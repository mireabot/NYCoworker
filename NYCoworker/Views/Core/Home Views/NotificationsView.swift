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
    @State var show = false
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    show.toggle()
                } label: {
                    Text("push")
                }
                
            }
            .popup(isPresented: $show) {
                NYCAlertView(title: "Added to favorites", alertStyle: .small)
            } customize: {
                $0
                    .isOpaque(true)
                    .autohideIn(1.5)
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring(response: 0.4, blendDuration: 0.2))
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
