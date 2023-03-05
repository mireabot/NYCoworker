//
//  GeoLocationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    
    @Published var userLocation : CLLocation!
    @Published var noLocation = false
    @Published var permissionDenied = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
            self.permissionDenied.toggle()
        default:
            print("unknown")
            self.noLocation = false
            // Direct Call
            locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist...
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // reading User Location And Extracting Details....
        self.userLocation = locations.last
    }
}
