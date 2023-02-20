//
//  ProfileView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import PopupView

struct ProfileView: View {
    @Binding var showPopup: Bool
    @State var showSettings = false
    @State var settingsTitle = ""
    var body: some View {
        VStack {
            /// Profile section
            VStack {
                VStack(alignment: .center, spacing: 5) {
                    Circle()
                        .frame(width: 100, height: 100)
                    Text("Michael")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 20))
                    Text("Coworker from 2023")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 13))
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Settings")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 16))
                    
                    ForEach(settigsData) { data in
                        VStack {
                            SettingsCard(data: data)
                                .onTapGesture {
                                    print(data.title)
                                    settingsTitle = data.title
                                    showSettings.toggle()
                                }
                        }
                    }
                }
                .padding([.leading,.trailing], 16)
                
                
                /// Bottom content
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Button {
                            showPopup.toggle()
                        } label: {
                            Text("Log out")
                                .foregroundColor(Resources.Colors.actionRed)
                                .font(Resources.Fonts.bold(withSize: 20))
                        }

                        Text("Version 1.0")
                            .foregroundColor(Resources.Colors.darkGrey)
                            .font(Resources.Fonts.regular(withSize: 16))
                    }
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.top, 10)
            }
            
            Spacer()
        }
        .hideTabbar(shouldHideTabbar: false)
        .navigationDestination(isPresented: $showSettings, destination: {
            SettingsView(title: settingsTitle)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NYCHeader(title: "Profile")
            }
        }
    }
}
