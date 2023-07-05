//
//  Resources.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/23/23.
//

import UIKit
import SwiftUI
import MapKit
import CoreLocation

enum Resources {
  
  static let isLogged = false
  static let mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7171577, longitude: -73.9950039), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
  
  static var userLocation : CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
  
  static var userName : String = ""
  static var userImageUrl: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/nycoworker-10d04.appspot.com/o/UserImages%2FIMG_0812%202.jpeg?alt=media&token=9c09e090-b4f1-4b40-861b-11910d920632")!
  
  static let websiteURL = URL(string: "https://www.nycoworker.com/")!
  static let termsOfServiceLink = "https://www.nycoworker.com/legal/terms-of-service"
  static let privacyLink = "https://www.nycoworker.com/legal/privacy-policy"
  
  static let messagingKey = "AAAAwu3VOMc:APA91bHuGsKCHSzJ7Y8CDaeglaS9eKNI7y98fAIW2Fa9O7cd4Djt5mOLhaNDf9gRIm58Csv9vtFdXnVAsIfSo-d9zK20WpLwoF_V7ygA-fjqm4EYwRu4S5OOlk7sUacxFUrY0vbyOHU_"
  static let demoToken = "cIALBfZOckzepPkMS4ikdW:APA91bEwZVpI3OEw8MMZtjwxDdU6bnssiyaCuqt4JIRGwT5p9qtVseBk9yT3QvlywYNBCRiUX2phw4MeJJt2lC3c1_zNIOTQuovDUM8ffFxHXyc6OgU6uuPyBY3IKmH5Y4OR1-c10FT-"
  
  static var adminMode = true
  
  /// Colors resource pack
  enum Colors {
    static let primary = Color(uiColor: UIColor(red: 0.11, green: 0.47, blue: 0.45, alpha: 1.00))
    static let secondary = Color(uiColor: UIColor(red: 0.03, green: 0.12, blue: 0.13, alpha: 1.00))
    
    static let customBlack = Color(uiColor: UIColor(red: 0.15, green: 0.16, blue: 0.19, alpha: 1.00))
    static let lightGrey = Color(uiColor: UIColor(red: 0.73, green: 0.76, blue: 0.80, alpha: 1.00))
    static let darkGrey = Color(uiColor: UIColor(red: 0.36, green: 0.38, blue: 0.40, alpha: 1.00))
    static let actionRed = Color(uiColor: UIColor(red: 0.89, green: 0.28, blue: 0.28, alpha: 1.00))
    static let actionGreen = Color(uiColor: UIColor(red: 0.22, green: 0.65, blue: 0.60, alpha: 1.00))
    static let customGrey = Color(uiColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00))
  }
  /// Images resource pack
  enum Images {
    /// Images for tab bar
    enum Tabs {
      static let homeTab = Image("home")
      static let socialTab = Image("social")
      static let profileTab = Image("profile")
      static let admin = Image("admin")
    }
    /// Images for navigation
    enum Navigation {
      static let arrowBack = Image("arrow-back")
      static let close = Image("close")
      static let chevronRight = Image("chevron-right")
      static let chevronLeft = Image("chevron-left")
      static let share = Image("share")
      static let location = Image("location")
      static let openMap = Image("open-map")
      static let refresh = Image("refresh")
      static let alert = Image("alert")
    }
    /// Images for settings
    enum Settings {
      static let manageAccount = Image("edit-account")
      static let help = Image("help")
      static let manageNotifications = Image("edit-notifications")
      static let changeLanguage = Image("language")
      static let website = Image("website")
      static let rate = Image("rate")
      static let faq = Image("faq")
      static let like = Image("like")
      static let notifications = Image("bell")
    }
    
    /// Flags of languages
    enum Flags {
      static let english = Image("English")
      static let russian = Image("Russian")
    }
    
    /// Images for social screen
    enum Social {
      static let search = Image("search")
      static let go = Image("go")
      static let mark = Image("mark")
    }
  }
  /// Fonts resource pack
  enum Fonts {
    /// Regular font
    static func regular(withSize size: CGFloat) -> Font {
      return Font.custom("Jost-Regular", size: size)
    }
    
    /// SemiBold font
    static func semiBold(withSize size: CGFloat) -> Font {
      return Font.custom("Jost-SemiBold", size: size)
    }
    
    /// Medium font
    static func medium(withSize size: CGFloat) -> Font {
      return Font.custom("Jost-Medium", size: size)
    }
    
    /// Bold font
    static func bold(withSize size: CGFloat) -> Font {
      return Font.custom("Jost-Bold", size: size)
    }
  }
}

enum Strings {
  /// Settings strings
  enum Settings {
    static let manageAccount = "Manage account"
    static let helpSupport = "Help & Support"
    static let manageNotifications = "Manage notifications"
  }
}


enum LocationR {
  enum General {
    static let pin = Image("pin")
  }
  
  enum Amenities {
    static let wifi = Image(systemName: "wifi")
    static let ac = Image(systemName: "snowflake")
    static let charge = Image(systemName: "bolt.fill")
    static let meeting = Image(systemName: "videoprojector.fill")
    static let pets = Image(systemName: "pawprint.fill")
    static let outdoor = Image(systemName: "sun.max.fill")
    static let rooftop = Image(systemName: "beach.umbrella.fill")
    static let silient = Image(systemName: "headphones")
    static let bar = Image(systemName: "takeoutbag.and.cup.and.straw.fill")
    static let wc = Image(systemName: "figure.dress.line.vertical.figure")
    static let printer = Image(systemName: "desktopcomputer")
    static let store = Image(systemName: "cart.fill")
  }
}
