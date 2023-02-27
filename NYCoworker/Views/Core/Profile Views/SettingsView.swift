//
//  SettingsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var nameTextFieldText = ""
    @State var occupationTextFieldText = ""
    @State var personType: String = "Student"
    var title: String
    var body: some View {
        NavigationStack {
            VStack {
                switch title {
                case Strings.Settings.manageAccount :
                    AccountSettingsView(nameText: $nameTextFieldText, occupationText: $occupationTextFieldText)
                case Strings.Settings.helpSupport:
                    SupportSettingsView()
                case Strings.Settings.manageNotifications:
                    NotificationsSettingsView()
                case Strings.Settings.language:
                    LanguageSettingsView()
                default:
                    EmptyView()
                }
            }
            .toolbar(.hidden, for: .tabBar)
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(title: "Title")
    }
}
