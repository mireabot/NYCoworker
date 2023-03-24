//
//  LocationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/6/23.
//

import SwiftUI
import Foundation
import MapKit

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
struct LocationModel: Identifiable, Equatable, Hashable {
    let name: String
    let coordinates: CLLocationCoordinate2D
    let address: String
    let images: [String]
    let locationType: LocationTypes
    let reviewsNumber: Int
    let distance: String
    
    var id: String {
        name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        lhs.id == rhs.id
    }
}

enum LocationTypes: String {
    case library = "Library"
    case hotel = "Hotel"
    case publicSpace = "Public space"
}

class LocationDataModel {
    static let locations: [LocationModel] = [
        LocationModel(name: "Ace Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7457029, longitude: -73.9905538), address: "20 W 29th St, New York, NY 10001", images: ["sample"], locationType: .hotel, reviewsNumber: 3, distance: "1.7 mi"),
        
        LocationModel(name: "Boro Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7620499, longitude: -73.9590397), address: "38-28 27th St, Queens, NY 11101", images: ["boro"], locationType: .hotel, reviewsNumber: 1, distance: "2 mi"),
        
        LocationModel(name: "The Ludlow Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7218644, longitude: -73.9894033), address: "180 Ludlow St, New York, NY 10002", images: ["ludow"], locationType: .hotel, reviewsNumber: 5, distance: "10 mi"),
        
        LocationModel(name: "The High Line Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7459912, longitude: -74.0071923), address: "180 10th Ave, New York, NY 10011", images: ["load"], locationType: .hotel, reviewsNumber: 2, distance: "0.8 mi")
    ]
    
    static let libraries: [LocationModel] = [
        LocationModel(name: "Adams Street Library", coordinates: CLLocationCoordinate2D(latitude: 40.7457029, longitude: -73.9905538), address: "20 W 29th St, New York, NY 10001", images: ["adams"], locationType: .hotel, reviewsNumber: 3, distance: "1.5 mi"),
        
        LocationModel(name: "New York Society Library", coordinates: CLLocationCoordinate2D(latitude: 40.7620499, longitude: -73.9590397), address: "38-28 27th St, Queens, NY 11101", images: ["soc"], locationType: .hotel, reviewsNumber: 1, distance: "2 mi"),
        
        LocationModel(name: "Yorkville NYPL", coordinates: CLLocationCoordinate2D(latitude: 40.7459912, longitude: -74.0071923), address: "180 10th Ave, New York, NY 10011", images: ["yorkville"], locationType: .hotel, reviewsNumber: 2, distance: "0.8 mi")
        
    ]
}
