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
    var locationImages: [String]
    var locationTags: [String]
    var reviews: Int
    var locationAddress: String
    
    var id: String {
        locationID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(locationName)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.locationID == rhs.locationID
    }
}

enum LocationType: String, Codable {
    case library = "Library"
    case hotel = "Hotel"
    case publicSpace = "Public space"
}

struct WorkingHours: Codable, Hashable {
    var hours: String
    var weekDay: String
}
