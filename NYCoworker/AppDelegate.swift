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
import FirebaseMessaging
import UserNotifications
import PostHog

@main
struct NYCoworkerApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  var body: some Scene {
    WindowGroup {
      SplashScreenView()
    }
  }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
  let gcmMessageIDKey = "gcm.message_id"
  let configuration = PHGPostHogConfiguration(apiKey: "phc_E4FM334KxpAwSTwAUlNSOWuys8ybX75DB0IFS32s8JF", host: "https://app.posthog.com")
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    FirebaseApp.configure()
    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().delegate = self
    application.registerForRemoteNotifications()
    
    configuration.captureApplicationLifecycleEvents = true
    PHGPostHog.setup(with: configuration)
    
    PHGPostHog.shared()?.capture("App launched")
    
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
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
    if let aps = userInfo["aps"] as? [String: Any], let badgeCount = aps["badge"] as? Int {
      // Set the badge count on the app icon
      application.applicationIconBadgeNumber = badgeCount
    }
    
    return UIBackgroundFetchResult.noData
  }
  
}

extension AppDelegate: MessagingDelegate{
  
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("FCM token: \(fcmToken ?? "")")
  }
  
  func messaging(_ messaging: Messaging, didReceive remoteMessage: Any) {
    print("Received remote message: \(remoteMessage)")
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("Device token: \(deviceToken.hexEncodedString())")
    
    // Set the APNS device token for Firebase Messaging
    Messaging.messaging().apnsToken = deviceToken
    
    // Re-retrieve the FCM token
    Messaging.messaging().token { token, error in
      if let error = error {
        print("Failed to retrieve FCM token: \(error.localizedDescription)")
      } else if let token = token {
        print("FCM token: \(token)")
        UserDefaults.standard.setValue(token, forKey: "FCMToken")
        UserDefaults.standard.synchronize()
      }
    }
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register for remote notifications: \(error.localizedDescription)")
  }
}

// User Notifications...[AKA InApp Notifications...]
extension AppDelegate : UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    print("User tapped notification")
    completionHandler()
  }
}

extension Data {
  func hexEncodedString() -> String {
    return map { String(format: "%02hhx", $0) }.joined()
  }
}
