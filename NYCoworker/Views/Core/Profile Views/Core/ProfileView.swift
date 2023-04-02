//
//  ProfileView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import PopupView
import Shimmer

struct ProfileView: View {
    @State var showPopup = false
    @State var showSettings = false
    @State private var userID = "GdtxTGfjweRU6BPejeWT"
    @StateObject private var userService = UserService()
    @State var isLoading = true
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    profileHeader()
                    
                    settingsView()
                    
                    profileFooter()
                }
                Spacer()
            }
            .task {
                guard userService.user.isEmpty else { return }
                await userService.fetchUser(documentId: userID, completion: {
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                })
            }
            .navigationDestination(for: SettingsModel.self, destination: { settingsData in
                SettingsView(title: settingsData.title)
            })
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
        if isLoading {
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
            .redacted(reason: .placeholder)
            .shimmering(active: true)
        }
        else {
            ForEach(userService.user,id: \.userID) { userData in
                VStack(alignment: .center, spacing: 5) {
                    Image("p1")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text(userData.name)
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 20))
                    Text("Coworker from 2023")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 13))
                }
            }
        }
    }
    
    @ViewBuilder
    func settingsView()-> some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 16))
            
            ForEach(settigsData, id: \.title) { data in
                VStack {
                    NavigationLink(value: data) {
                        SettingsCard(data: data)
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
