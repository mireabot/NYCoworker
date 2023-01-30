//
//  GeoLocationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI
import CoreLocation

class LocationModel: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var status: Bool?
    static let shared = LocationModel()
    
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation(compleationHandler:()->Void) {
        manager.requestWhenInUseAuthorization()
        compleationHandler()
    }
}

extension LocationModel : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print(".notDetermined")
            self.status = false
        case .restricted:
            print(".restricted")
            self.status = false
        case .denied:
            print(".denied")
            self.status = false
        case .authorizedAlways:
            print(".authorizedAlways")
            self.status = true
        case .authorizedWhenInUse:
            print(".authorizedWhenInUse")
            self.status = true
        case .authorized:
            print("authorized")
            self.status = true
        @unknown default:
            fatalError("Error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }
}
