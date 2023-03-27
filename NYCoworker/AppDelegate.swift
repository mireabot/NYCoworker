//
//  AppDelegate.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/23/23.
//

import UIKit
import SwiftUI
import Firebase

@main
struct NYCoworkerApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        FirebaseApp.configure()
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

struct SplashScreenView: View {
    @State var isActive : Bool = true
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            InitView()
        } else {
            VStack {
                VStack {
                    Image("appLogo")
                        .resizable()
                        .frame(width: 150, height: 150)
                    Text("NYCoworker")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 28))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct InitView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("userSigned") var userLogged: Bool = false
    var body: some View {
        if userLogged  {
            TabBarView()
        }
        else {
            Onboarding()
        }
    }
}

struct ContentView1: View {
    @State private var isPresentingSheet = false
    @State private var selectDetent: PresentationDetent = .bottom
    var body: some View {
        Button(action: {
            isPresentingSheet = true
        }) {
            Text("Open Bottom Sheet")
        }
        .sheet(isPresented: $isPresentingSheet) {
            LanguageSetup()
                .presentationDetents(
                    [.bottom, .mediumBottomBar],
                    selection: $selectDetent
                )
        }
    }
}
