//
//  LocationsViewModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/6/23.
//

import SwiftUI
import MapKit

@MainActor
final class LocationsViewModel: ObservableObject {
    static let shared: LocationsViewModel = .init()
    @Published var locations: [LocationModel]
    @Published var librariesLocations: [LocationModel]
    @Published var mapLocation: LocationModel {
        didSet {
            updateRegion(location: mapLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    init() {
        let locations = LocationDataModel.locations
        let libraries = LocationDataModel.libraries
        self.locations = locations
        self.librariesLocations = libraries
        self.mapLocation = locations.first!
        self.updateRegion(location: locations.first!)
    }
    
    private func updateRegion(location: LocationModel) {
        withAnimation(.easeOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: span)
        }
    }
    
    func showNextLocation(location: LocationModel) {
        withAnimation(.easeOut) {
            mapLocation = location
        }
    }
    
    func pushNextLocation() {
        guard let index = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        let nextIndex = index + 1
        guard locations.indices.contains(nextIndex) else {
            guard let location = locations.first else {
                return
            }
            showNextLocation(location: location)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    func resetLocation() {
        let location = LocationDataModel.locations
        mapLocation = location[0]
    }
}

extension LocationsViewModel: Hashable, Identifiable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    var identifier: String {
        return UUID().uuidString
    }
    public static func == (lhs: LocationsViewModel, rhs: LocationsViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
