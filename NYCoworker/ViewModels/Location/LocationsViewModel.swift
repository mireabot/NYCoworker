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
    @Published var mapLocation: LocationModel {
        didSet {
            updateRegion(location: mapLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    init() {
        let locations = LocationDataModel.locations
        self.locations = locations
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
            Task { @MainActor in
                showNextLocation(location: location)
            }
            return
        }
        
        let nextLocation = locations[nextIndex]
        Task { @MainActor in
            showNextLocation(location: nextLocation)
        }
    }
    
    func resetLocation() {
        let location = LocationDataModel.locations
        mapLocation = location[0]
    }
}
