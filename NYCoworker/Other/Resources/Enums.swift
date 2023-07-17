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
}

//MARK: - Pop alerts type enum
/// Stores title and icon of top pop alerts
enum PopAlertType {
  case addedToFavorites
  case dataUploaded
  case reportSubmitted
  case feedbackSent
  case reviewUploaded
  
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
    }
  }
}

enum AlertType {
  case notification
  case geoposition
  
  var title: String {
    switch self {
    case .notification:
      return "Notifications are off"
    case .geoposition:
      return "Geoposition is off"
    }
  }
  var subtitle: String {
    switch self {
    case .notification:
      return "You can turn on notification later in settings"
    case .geoposition:
      return "You can turn on geoposition later in settings"
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
