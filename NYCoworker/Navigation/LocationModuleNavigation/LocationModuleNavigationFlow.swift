//
//  LocationModuleNavigationFlow.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 7/16/23.
//

import Foundation
import SwiftUI


/// Navigation flow for locations module
/// Contains data which need to be passed, navigation logic
class LocationModuleNavigationFlow: ObservableObject {
  static let shared = LocationModuleNavigationFlow()
  
  @Published var path = NavigationPath()
  @Published var arrayOfLocations: [Location] = []
  @Published var selectedLocation: Location = Location.mock
  @Published var selectedSetOfLocations: [Location] = []
  @Published var selectedListTitle: String = Locations.empty.headerTitle
  @Published var setOfNotifications: [Notification] = []
  
  func clear() {
    path = .init()
  }
  
  func navigateBackToRoot() {
    path.removeLast(path.count)
  }
  
  func backToPrevious() {
    path.removeLast()
  }
  
  func navigateToDetailView() {
    path.append(LocationModuleNavigationDestinations.locationDetailView)
  }
  
  func navigateToListView() {
    path.append(LocationModuleNavigationDestinations.locationsListView)
  }
  
  func navigateToFavoriteView() {
    path.append(LocationModuleNavigationDestinations.favoritesView)
  }
  
  func navigateToNotificationsView() {
    path.append(LocationModuleNavigationDestinations.notificationsView)
  }
  
  func navigateToMapView() {
    path.append(LocationModuleNavigationDestinations.mapView)
  }
  
  func done() {
    path = .init()
  }
}


