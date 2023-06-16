//
//  AnalyticsManager.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/16/23.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
  private init() {}
  
  static let shared = AnalyticsManager()
  
  
  public func log(_ event: AnalyticsEvents) {
    switch event {
    case .accountCreated:
      Analytics.logEvent(event.eventName, parameters: [:])
    case .openMap:
      Analytics.logEvent(event.eventName, parameters: [:])
    case .locationSelected(let locationID):
      Analytics.logEvent(event.eventName, parameters: ["locationID":locationID])
    case .openFavorites(let userID):
      Analytics.logEvent(event.eventName, parameters: ["userID": userID])
    case .locationAddedToFavs(let locationID):
      Analytics.logEvent(event.eventName, parameters: ["locationID":locationID])
    case .reviewOpened(let locationID):
      Analytics.logEvent(event.eventName, parameters: ["locationID":locationID])
    case .reviewSubmitted(let locationID):
      Analytics.logEvent(event.eventName, parameters: ["locationID":locationID])
    case .routeButtonPressed(let locationID):
      Analytics.logEvent(event.eventName, parameters: ["locationID":locationID])
    case .deleteButtonPressed:
      Analytics.logEvent(event.eventName, parameters: [:])
    case .deleteButtonSubmitted:
      Analytics.logEvent(event.eventName, parameters: [:])
    case .feedbackOpened:
      Analytics.logEvent(event.eventName, parameters: [:])
    case .feedbackSubmitted:
      Analytics.logEvent(event.eventName, parameters: [:])
    case .websiteOpened:
      Analytics.logEvent(event.eventName, parameters: [:])
    }
  }
}

enum AnalyticsEvents {
  case accountCreated
  case openMap
  case locationSelected(String)
  case openFavorites(String)
  case locationAddedToFavs(String)
  case reviewOpened(String)
  case reviewSubmitted(String)
  case routeButtonPressed(String)
  case deleteButtonPressed
  case deleteButtonSubmitted
  case feedbackOpened
  case feedbackSubmitted
  case websiteOpened
  
  var eventName: String {
    switch self {
    case .accountCreated: return "accountCreatedEvent"
    case .openMap: return "mapOpened"
    case .locationSelected: return "locationSelected"
    case .openFavorites: return "favoritesOpened"
    case .locationAddedToFavs: return "locationAddedToFavs"
    case .reviewOpened: return "reviewScreenOpened"
    case .reviewSubmitted: return "reviewWasSubmitted"
    case .routeButtonPressed: return "routeButtonPressed"
    case .deleteButtonPressed: return "deleteAccountButtonPressed"
    case .deleteButtonSubmitted: return "deleteAcccountAction"
    case .feedbackOpened: return "feedbackScreenOpened"
    case .feedbackSubmitted: return "feedbackSubmitted"
    case .websiteOpened: return "websiteOpened"
    }
  }
}
