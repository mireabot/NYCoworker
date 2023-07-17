//
//  ProfileModuleNavigationFlow.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 7/17/23.
//

import Foundation
import SwiftUI


/// Navigation flow for profile module
/// Contains data which need to be passed, navigation logic
class ProfileModuleNavigationFlow: ObservableObject {
  static let shared = ProfileModuleNavigationFlow()
  
  @Published var path = NavigationPath()
  @Published var currentUser: User = .mock
  
  func clear() {
    path = .init()
  }
  
  func navigateBackToRoot() {
    path.removeLast(path.count)
  }
  
  func backToPrevious() {
    path.removeLast()
  }
  
  func navigateToAccountEditView() {
    path.append(ProfileModuleNavigationDestinations.accountEditView)
  }
  
  func navigateToSupportView() {
    path.append(ProfileModuleNavigationDestinations.supportView)
  }
  
  func navigateToFeedbackView() {
    path.append(ProfileModuleNavigationDestinations.createFeedbackView)
  }
  
  func done() {
    path = .init()
  }
}

