//
//  LocationModuleNavigationFactory.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 7/16/23.
//

import Foundation
import SwiftUI

class LocationModuleNavigationFactory {
  
  static func setViewForDestination(_ destination: LocationModuleNavigationDestinations) -> AnyView {
    switch destination {
    case .favoritesView:
      return AnyView(FavoriteLocationsView())
    case .notificationsView:
      return AnyView(NotificationsView())
    case .locationDetailView:
      return AnyView(LocationDetailView())
    case .locationsListView:
      return AnyView(LocationListView())
    case .mapView:
      return AnyView(LocationsMap())
    }
  }
}

