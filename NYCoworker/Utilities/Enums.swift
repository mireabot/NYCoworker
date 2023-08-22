//
//  Enums.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI

//MARK: - Locations enum
/// Used in Home view and location lists views as header and type of displaying locations
enum Locations {
  case libraries
  case lobbies
  case publicSpaces
  case cafe
  case empty
  
  var headerTitle: String {
    switch self {
    case .libraries: return "Quiet Libraries"
    case .lobbies: return "Busy Lobbies"
    case .publicSpaces: return "Public Spaces"
    case .cafe: return "Cozy cafés"
    case .empty: return "Placeholder"
    }
  }
}

//MARK: - Locations types enum
/// Used as part of Location model
enum LocationType: String, Codable {
  case library = "Library"
  case hotel = "Hotel"
  case publicSpace = "Public space"
  case cafe = "Café"
}

//MARK: - Endpoints enum
/// Stores names of collection in Firestore
enum Endpoints: String {
  case users = "User"
  case notifications = "Notifications"
  case reviews = "Reviews"
  case locations = "Locations"
  case feedback = "Feedbacks"
  case suggestions = "Suggestions"
}

//MARK: - Alerts type enum

/// Stores title and icon for top alerts
enum TopAlertType {
  case addedToFavorites
  case dataUploaded
  case reportSubmitted
  case feedbackSent
  case reviewUploaded
  case removedFromFavorites
  
  var title: String {
    switch self {
    case .addedToFavorites:
      return "Added to favorites"
    case .dataUploaded:
      return "Successfully updated"
    case .reportSubmitted:
      return "Report submitted"
    case .feedbackSent:
      return "We received your feedback"
    case .reviewUploaded:
      return "Your review is live!"
    case .removedFromFavorites:
      return "Removed from favorites"
    }
  }
  
  var icon: Image {
    switch self {
    case .addedToFavorites:
      return Image("favs")
    case .dataUploaded:
      return Image("dataUploaded")
    case .reportSubmitted:
      return Image("dataUploaded")
    case .feedbackSent:
      return Image("dataUploaded")
    case .reviewUploaded:
      return Image("dataUploaded")
    case .removedFromFavorites:
      return Image("favs")
    }
  }
}

/// Stores title and text for middle view alerts
enum MiddleAlertType {
  case reviewUnderReview
  case notificationsRejected
  case geolocationRejected
  case feedbackSubmitted
  case suggestionSubmitted
  case accountUpdated
  
  var title: String {
    switch self {
    case .reviewUnderReview: return "We're reviewing your submission"
    case .notificationsRejected: return "You will not receive notifications"
    case .geolocationRejected: return "Location Services Denied"
    case .feedbackSubmitted: return "Thanks for sharing!"
    case .suggestionSubmitted: return "Thanks for sharing!"
    case .accountUpdated: return "Your profile was updated!"
    }
  }
  
  var text: String {
    switch self {
    case .reviewUnderReview: return "Thanks for sharing your opinion! Our team'll review it in 1-2 days and send a push when it goes live."
    case .notificationsRejected: return "No worries! Enable notifications in settings if you change your mind."
    case .geolocationRejected: return "No worries! You won't see distance from locations unless you turn location services in settings."
    case .feedbackSubmitted: return "Hearing from you helps us to create the best NYCoworker experience."
    case .suggestionSubmitted: return "Hearing from you helps us to create the best NYCoworker experience."
    case .accountUpdated: return "New data successfully saved and will be updated shortly."
    }
  }
}

//MARK: - Bottom view content enum
/// Stores header and text values for bottom views content
enum BottomViewContent {
  case deleteAccount
  
  var header: String {
    switch self {
    case .deleteAccount:
      return "Are you sure you want to delete account?"
    }
  }
  
  var text: String {
    switch self {
    case .deleteAccount:
      return "We will delete your account and all related information from our database."
    }
  }
}

//MARK: - Settings Card data enum
enum SettingsData {
  case manageAccount
  case help
  case visitWebsite
  case rateApp
  case writeFeedback
  
  var icon: Image {
    switch self {
    case .manageAccount:
      return Resources.Images.Settings.manageAccount
    case .help:
      return Resources.Images.Settings.help
    case .visitWebsite:
      return Resources.Images.Settings.website
    case .rateApp:
      return Resources.Images.Settings.rate
    case .writeFeedback:
      return Resources.Images.Settings.manageAccount
    }
  }
  
  var title: String {
    switch self {
    case .manageAccount:
      return Strings.Settings.manageAccount
    case .help:
      return Strings.Settings.helpSupport
    case .visitWebsite:
      return Strings.Settings.visitWebsite
    case .rateApp:
      return Strings.Settings.rateApp
    case .writeFeedback:
      return Strings.Settings.writeFeedback
    }
  }
}
