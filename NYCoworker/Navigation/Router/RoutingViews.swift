//
//  RoutingViews.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/24/23.
//

import Foundation

enum RoutingViews: Equatable, Hashable {
    
    case main
    case list
    case detail(String)
    case alert
    case mapView
    case locationList(String)
    case locationDetail
    case settingsView(String)
    case notificationsView
    case favoritesView
}

extension RoutingViews: Identifiable {
    
    var id: Self { self }
}

