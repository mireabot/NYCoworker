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
  static let mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7171577, longitude: -73.9950039), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
  
  static var userLocation : CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
  
  static var userName : String = ""
  static var userImageUrl: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/nycoworker-10d04.appspot.com/o/UserImages%2FIMG_0812%202.jpeg?alt=media&token=9c09e090-b4f1-4b40-861b-11910d920632")!
  
  static var adminMode = false
  
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
      static let homeTab = UIImage(named: "home")
      static let socialTab = UIImage(named: "social")
      static let profileTab = UIImage(named: "profile")
      static let admin = UIImage(named: "admin")
    }
    /// Images for navigation
    enum Navigation {
      static let arrowBack = Image("arrow-back")
      static let close = Image("close")
      static let chevron = Image("chevron-right")
      static let share = Image("share")
      static let location = Image("location")
      static let openMap = Image("open-map")
      static let refresh = Image("refresh")
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
    static let wifi = Image("wi-fi")
    static let ac = Image("ac")
    static let charge = Image("charge")
    static let meeting = Image("meeting")
  }
}
