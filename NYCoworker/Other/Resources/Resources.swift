//
//  Resources.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/23/23.
//

import UIKit
import SwiftUI

enum Resources {
    
    static let isLogged = true
    
    /// Colors resource pack
    enum Colors {
        static let primary = Color(uiColor: UIColor(red: 0.11, green: 0.47, blue: 0.45, alpha: 1.00))
        static let secondary = UIColor(red: 0.03, green: 0.12, blue: 0.13, alpha: 1.00)
        
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
        }
        /// Images for navigation
        enum Navigation {
            static let arrowBack = Image("arrow-back")
            static let close = Image("close")
        }
    }
    /// Fonts resource pack
    enum Fonts {
        /// Regular font
        static func regular(withSize size: CGFloat) -> Font {
            return Font.custom("Nunito-Regular", size: size)
        }
        
        /// SemiBold font
        static func semiBold(withSize size: CGFloat) -> Font {
            return Font.custom("Nunito-SemiBold", size: size)
        }
        
        /// Bold font
        static func bold(withSize size: CGFloat) -> Font {
            return Font.custom("Nunito-Bold", size: size)
        }
    }
}
