//
//  ProfileView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import PopupView

struct ProfileView: View {
    @State var showPopup = false
    @State var showSettings = false
    @State var settingsTitle = ""
    @StateObject private var router: NYCRouter
    init(router: NYCRouter) {
        _router = StateObject(wrappedValue: router)
    }
    var body: some View {
        RoutingView(router: router) {
            VStack {
                VStack {
                    profileHeader()
                    
                    settingsView()
                    
                    profileFooter()
                }
                Spacer()
            }
            .sheet(isPresented: $showPopup, content: {
                LogoutView()
                    .presentationDetents([.bottom])
            })
            .hideTabbar(shouldHideTabbar: false)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NYCHeader(title: "Profile")
                }
            }
        }
    }
}

extension ProfileView {
    @ViewBuilder
    func profileHeader()-> some View {
        VStack(alignment: .center, spacing: 5) {
            Image("p1")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Michael")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 20))
            Text("Coworker from 2023")
                .foregroundColor(Resources.Colors.darkGrey)
                .font(Resources.Fonts.regular(withSize: 13))
        }
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    func settingsView()-> some View {
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
                            router.navigateTo(.settingsView(settingsTitle))
                        }
                }
            }
        }
        .padding([.leading,.trailing], 16)
    }
    
    @ViewBuilder
    func profileFooter()-> some View {
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
}
