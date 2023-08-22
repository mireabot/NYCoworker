//
//  AnalyticsManager.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/16/23.
//

import Foundation
import PostHog

final class AnalyticsManager {
  private init() {}
  
  static let shared = AnalyticsManager()
  
  
  public func log(_ event: AnalyticsEvents) {
    if Resources.adminMode {
      print("Admin mode ON")
    }
    else {
      switch event {
      case .accountCreated:
        PHGPostHog.shared()?.capture(event.eventName)
      case .openMap:
        PHGPostHog.shared()?.capture(event.eventName)
      case .locationSelected(let locationID):
        PHGPostHog.shared()?.capture(event.eventName, properties: ["location" : locationID])
      case .openFavorites:
        PHGPostHog.shared()?.capture(event.eventName)
      case .locationAddedToFavs(let locationID):
        PHGPostHog.shared()?.capture(event.eventName, properties: ["location" : locationID])
      case .reviewOpened(let locationID):
        PHGPostHog.shared()?.capture(event.eventName, properties: ["location" : locationID])
      case .reviewSubmitted(let locationID):
        PHGPostHog.shared()?.capture(event.eventName, properties: ["location" : locationID])
      case .routeButtonPressed(let locationID):
        PHGPostHog.shared()?.capture(event.eventName, properties: ["location" : locationID])
      case .deleteButtonPressed:
        PHGPostHog.shared()?.capture(event.eventName)
      case .deleteButtonSubmitted:
        PHGPostHog.shared()?.capture(event.eventName)
        PHGPostHog.shared()?.reset()
      case .feedbackSubmitted:
        PHGPostHog.shared()?.capture(event.eventName)
      case .websiteOpened:
        PHGPostHog.shared()?.capture(event.eventName)
      case .notificationWasOpened:
        PHGPostHog.shared()?.capture(event.eventName)
      case .locationSuggestionWasOpened:
        PHGPostHog.shared()?.capture(event.eventName)
      case .locationSuggestionWasSubmitted:
        PHGPostHog.shared()?.capture(event.eventName)
      case .locationRemovedFromFavs(let locationID):
        PHGPostHog.shared()?.capture(event.eventName, properties: ["location" : locationID])
      }
    }
  }
}

enum AnalyticsEvents {
  case accountCreated
  case openMap
  case locationSelected(String)
  case openFavorites
  case locationAddedToFavs(String)
  case locationRemovedFromFavs(String)
  case reviewOpened(String)
  case reviewSubmitted(String)
  case routeButtonPressed(String)
  case deleteButtonPressed
  case deleteButtonSubmitted
  case feedbackSubmitted
  case websiteOpened
  case notificationWasOpened
  case locationSuggestionWasOpened
  case locationSuggestionWasSubmitted
  
  var eventName: String {
    switch self {
    case .accountCreated: return "accountWasCreated"
    case .openMap: return "mapOpened"
    case .locationSelected: return "userSelectedLocation"
    case .openFavorites: return "favoritesOpened"
    case .locationAddedToFavs: return "locationAddedToFavs"
    case .reviewOpened: return "reviewScreenOpened"
    case .reviewSubmitted: return "reviewWasSubmitted"
    case .routeButtonPressed: return "routeButtonPressed"
    case .deleteButtonPressed: return "deleteAccountButtonPressed"
    case .deleteButtonSubmitted: return "accountWasDeleted"
    case .feedbackSubmitted: return "feedbackSubmitted"
    case .websiteOpened: return "websiteOpened"
    case .notificationWasOpened: return "notificationsOpened"
    case .locationSuggestionWasOpened: return "Location suggestion was opened"
    case .locationSuggestionWasSubmitted: return "Location was suggested to app"
    case .locationRemovedFromFavs: return "locationRemovedFromFavs"
    }
  }
}
