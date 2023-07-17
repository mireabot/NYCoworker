//
//  TabBarView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/4/23.
//

import SwiftUI
import PopupView

struct TabBarView: View {
  @AppStorage("UserID") var userId : String = ""
  var body: some View {
    TabView {
      HomeView()
        .environmentObject(LocationModuleNavigationFlow.shared)
        .tabItem {
          Label("Explore", image: "home")
        }
      NavigationStack {
        SocialView()
      }
      .tabItem {
        Label("Coworkers", image: "social")
      }
      ProfileView()
        .tabItem {
          Label("Profile", image: "profile")
        }
      
      if Resources.adminMode {
        AdminHomeView()
          .tabItem {
            Label("Admin", image: "admin")
          }
      }
    }
    .accentColor(Resources.Colors.primary)
    .onAppear() {
      if #available(iOS 13.0, *) {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
          UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
      }
    }
  }
}

struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
