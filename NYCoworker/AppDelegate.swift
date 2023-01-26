//
//  AppDelegate.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/23/23.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


struct TestView: View {
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView {
                Text("Home")
                    .tabItem {
                        Label("Home", image: "home")
                    }
                Text("Coworkers")
                    .tabItem {
                        Label("Coworkers", image: "social")
                    }
                Text("Profile")
                    .tabItem {
                        Label("Profile", image: "profile")
                    }
            }
            .accentColor(Resources.Colors.primary)
        }
    }
}

@main
struct RemMemberAdminApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            Onboarding()
        }
    }
}


struct C_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
