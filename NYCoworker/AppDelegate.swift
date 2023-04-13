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
    @StateObject private var networkManager = NetworkMonitor()
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
    var body: some View {
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
            .onAppear {
                logIn()
            }
        }
    }
    
    func logIn() {
        if userLogged {
            Task {
                do {
                    try await Auth.auth().signIn(withEmail: userMail, password: userPass)
                    isActive = true
                }
                catch {
                    await setError(error)
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
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            isActive = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct InitView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("userSigned") var userLogged: Bool = false
    @AppStorage("UserID") var userId : String = ""
    var body: some View {
        if userLogged && !userId.isEmpty  {
            TabBarView()
        }
        else {
            Onboarding()
        }
    }
}


import Network
public class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workQueue = DispatchQueue(label: "Monitor")
    public var isConnected = false
    
    public init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run(body: {
                    self.objectWillChange.send()
                })
            }
        }
        networkMonitor.start(queue: workQueue)
    }
}

struct ContentView: View {
    @EnvironmentObject private var networkManager: NetworkMonitor
    @State var isLoading : Bool = true
    var body: some View {
        ZStack {
            if networkManager.isConnected {
//                SplashScreenView()
                Text("Interner")
            }
            else {
                Text("Error")
            }
        }
    }
}
