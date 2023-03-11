//
//  TabBarView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/4/23.
//

import SwiftUI
import BottomSheet
import PopupView

struct TabBarView: View {
    @State var showBottomsheet = false
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Explore", image: "home")
            }
            NavigationStack {
                SocialView()
            }
            .tabItem {
                Label("Coworkers", image: "social")
            }
            NavigationStack {
                ProfileView(showPopup: $showBottomsheet)
            }
            .tabItem {
                Label("Profile", image: "profile")
            }
        }
        .sheet(isPresented: $showBottomsheet, content: {
            LogoutView()
                .presentationDetents([.bottom])
        })
        .accentColor(Resources.Colors.primary)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
