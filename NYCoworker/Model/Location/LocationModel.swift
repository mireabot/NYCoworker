//
//  LocationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/6/23.
//

import SwiftUI
import Foundation
import MapKit

struct LocationModel: Identifiable, Equatable {
    let name: String
    let coordinates: CLLocationCoordinate2D
    let address: String
    let images: [String]
    let locationType: LocationTypes
    let reviewsNumber: Int
    
    var id: String {
        name
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
        LocationModel(name: "Ace Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7457029, longitude: -73.9905538), address: "20 W 29th St, New York, NY 10001", images: ["load"], locationType: .hotel, reviewsNumber: 3),
        
        LocationModel(name: "Boro Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7620499, longitude: -73.9590397), address: "38-28 27th St, Queens, NY 11101", images: ["load"], locationType: .hotel, reviewsNumber: 1),
        
        LocationModel(name: "The Ludlow Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7218644, longitude: -73.9894033), address: "180 Ludlow St, New York, NY 10002", images: ["load"], locationType: .hotel, reviewsNumber: 6),
        
        LocationModel(name: "The High Line Hotel", coordinates: CLLocationCoordinate2D(latitude: 40.7459912, longitude: -74.0071923), address: "180 10th Ave, New York, NY 10011", images: ["load"], locationType: .hotel, reviewsNumber: 10)
    ]
}
