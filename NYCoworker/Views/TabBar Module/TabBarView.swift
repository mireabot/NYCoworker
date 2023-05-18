//
//  TabBarView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/4/23.
//

import SwiftUI
import PopupView

struct TabBarView: View {
  @State var showBottomsheet = false
  @AppStorage("UserID") var userId : String = ""
  @StateObject private var userService = UserService()
  var body: some View {
    TabView {
      HomeView()
        .environmentObject(userService)
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
        .environmentObject(userService)
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
    .task {
      guard userService.user.userID.isEmpty else { return }
      await userService.fetchUser(documentId: userId, completion: {
        print("User fetched")
        Resources.userName = userService.user.name
        Resources.userImageUrl = userService.user.avatarURL
      })
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
