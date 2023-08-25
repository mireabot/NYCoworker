//
//  LocationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/6/23.
//

import SwiftUI
import Foundation
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift

/// Data model for Locations
///
/// Used in location cards in home,map views
///  - Parameters:
///    - name: name of location
///    - coordinates: point on map for location
///    - address: address of location
///    - images: array of images for location
///    - locationType: type of location
///    - reviewsNumber: number of references for location in Reviews database
///    - distance: counts from current user's location to final destination when app launches
///
/// - Returns: LocationModel struct object
struct Location: Identifiable, Codable, Equatable, Hashable {
  var locationName: String
  var locationCoordinates: GeoPoint
  var locationType: LocationType
  var locationID: String
  var locationAmenities: [String]
  var locationHours: [WorkingHours]
  var locationImages: [URL]
  var locationTags: [String]
  var reviews: Int
  var locationUpdates: [LocationUpdates]?
  var locationAddress: String
  var locationPriority: Bool
  
  var id: String {
    locationID
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(locationName)
  }
  
  static func == (lhs: Location, rhs: Location) -> Bool {
    lhs.locationID == rhs.locationID
  }
  
  static let mock = Location(locationName: "Adams Library", locationCoordinates: GeoPoint(latitude: 0.0, longitude: 0.0), locationType: .library, locationID: "id", locationAmenities: ["Wi-Fi","Accessible","Quiet space","Meeting room","Work station","Charging","A/C","W/C"], locationHours: WorkingHours.mock, locationImages: [URL(string: "https://firebasestorage.googleapis.com/v0/b/nycoworker-10d04.appspot.com/o/LocationImages%2F1.png?alt=media&token=1d1fa8d4-367c-480e-b8bc-9fd5c6d72dc8")!], locationTags: ["New"], reviews: 0, locationUpdates: LocationUpdates.mock, locationAddress: "Address", locationPriority: true)
}

struct WorkingHours: Codable, Hashable {
  var hours: String
  var weekDay: String
  
  static let mock : [WorkingHours] = [
    WorkingHours(hours: "8AM - 8PM", weekDay: "Monday"),
    WorkingHours(hours: "8AM - 8PM", weekDay: "Tuesday"),
    WorkingHours(hours: "8AM - 8PM", weekDay: "Wednesday"),
    WorkingHours(hours: "8AM - 8PM", weekDay: "Thursday"),
    WorkingHours(hours: "8AM - 8PM", weekDay: "Friday"),
    WorkingHours(hours: "Closed", weekDay: "Saturday"),
    WorkingHours(hours: "Closed", weekDay: "Sunday")
  ]
}

struct LocationUpdates: Codable, Hashable {
  var title: String
  var text: String
  var url: String
  
  static let mock : [LocationUpdates] = [
    LocationUpdates(title: "Sample title", text: "Need to reserve a table", url: "nycoworker.com")
  ]
}
