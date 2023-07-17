//
//  ProfileModuleNavigationFactory.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 7/17/23.
//

import Foundation
import SwiftUI

class ProfileModuleNavigationFactory {
  
  static func setViewForDestination(_ destination: ProfileModuleNavigationDestinations) -> AnyView {
    switch destination {
    case .accountEditView:
      return AnyView(AccountSettingsView())
    case .createFeedbackView:
      return AnyView(WriteFeedbackView())
    case .supportView:
      return AnyView(SupportSettingsView())
    }
  }
}


