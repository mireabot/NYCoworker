//
//  SettingsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var makeDismiss
    private var title: String
    init(title: String) {
        self.title = title
    }
    @EnvironmentObject var userService : UserService
    var body: some View {
        VStack {
            switch title {
            case Strings.Settings.manageAccount :
                AccountSettingsView().environmentObject(userService)
            case Strings.Settings.helpSupport:
                SupportSettingsView()
            default:
                EmptyView()
            }
        }
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
                Text(title)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 17))
            }
        })
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .toolbarBackground(.white, for: .navigationBar)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(title: "Title")
    }
}
