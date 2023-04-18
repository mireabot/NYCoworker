//
//  AppDelegate.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/23/23.
//

import UIKit
import SwiftUI
import Firebase
import CoreLocation

@main
struct NYCoworkerApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}


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

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State var errorMessage = ""
    @State var showError = false
    @AppStorage("userSigned") var userLogged: Bool = false
    @AppStorage("UserID") var userId : String = ""
    @AppStorage("UserMail") var userMail : String = ""
    @AppStorage("UserPass") var userPass : String = ""
    @StateObject var userService = UserService()
    var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            if isActive {
                InitView()
            } else {
                VStack {
                    VStack {
                        Image("appLogo")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                }
            }
        }
        .overlay(content: {
            NYCBottomErrorAlert(show: $showError, errorTitle: errorMessage) {
                showError.toggle()
                performLogIn()
            }
        })
        .onAppear {
            performLogIn()
        }
    }
    
    func performLogIn() {
        if userLogged {
            Task {
                await userService.logIn(withEmail: userMail,withPass: userPass, completion: {
                    isActive = true
                }) { err in
                    setError(err)
                }
            }
        }
        else {
            print("Not logged")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isActive = true
            }
        }
    }
    
    func setError(_ error: Error) {
        isActive = false
        errorMessage = parseAuthError(error)
        withAnimation {
            showError.toggle()
        }
    }
}

struct InitView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("userSigned") var userLogged: Bool = false
    @AppStorage("UserID") var userId : String = ""
    @State var appConfig: AppConfig?
    @State var isMaintenanceMode = false
    var body: some View {
        Group {
            if userLogged && !userId.isEmpty  {
                TabBarView()
                    .fullScreenCover(isPresented: $isMaintenanceMode) {
                        MaintenanceOverlayView()
                    }
            }
            else {
                Onboarding()
            }
        }
        .onAppear {
            fetchAppConfig()
        }
    }
    
    func fetchAppConfig() {
        let db = Firestore.firestore()
        db.collection("AppConfig").document("iF6wRzrbgSP8YI9hbCLl").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting appConfig: \(error)")
            } else if let data = snapshot?.data() {
                // Decode AppConfig struct from database
                do {
                    let appConfig = try Firestore.Decoder().decode(AppConfig.self, from: data)
                    self.appConfig = appConfig
                    self.isMaintenanceMode = appConfig.maintainceMode
                } catch {
                    print("Error decoding appConfig: \(error)")
                }
            }
        }
    }
}

import Foundation
import Network

class MonitoringNetworkState: ObservableObject {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected = false
    
    init() {
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }
    }
}
