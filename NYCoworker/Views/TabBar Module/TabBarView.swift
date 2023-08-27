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
  let nav = NavigationControllers()
  let router = NYCNavigationViewsRouter()
  var body: some View {
    TabView {
      RootNavigationController(nav: nav.locationFeedNavigationController, rootView: HomeView())
        .tabItem {
          Label("Explore", image: "home")
        }
        .environmentObject(router)
        .onAppear {
          router.nav = nav.locationFeedNavigationController
        }
      NavigationStack {
        SocialView()
      }
      .tabItem {
        Label("Coworkers", image: "social")
      }
      RootNavigationController(nav: nav.profileNavigationController, rootView: ProfileView())
        .tabItem {
          Label("Profile", image: "profile")
        }
        .environmentObject(router)
        .onAppear {
          router.nav = nav.profileNavigationController
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
          let navigationBarAppearance = UINavigationBarAppearance()
          let atters: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Jost-Medium", size: 17)!
              ]
          navigationBarAppearance.backgroundColor = .white
          navigationBarAppearance.shadowColor = .clear
          navigationBarAppearance.titleTextAttributes = atters
          UINavigationBar.appearance().standardAppearance = navigationBarAppearance
          UINavigationBar.appearance().compactAppearance = navigationBarAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
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
