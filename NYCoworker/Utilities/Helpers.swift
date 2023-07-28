//
//  Helpers.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/18/23.
//

import MapKit
import CoreLocation

func openInGoogleMaps(withLocation location: CLLocationCoordinate2D) {
    let url = URL(string: "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")
    if UIApplication.shared.canOpenURL(url!) {
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    else{
        let urlBrowser = URL(string: "https://www.google.co.in/maps/dir/??saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")
        
        UIApplication.shared.open(urlBrowser!, options: [:], completionHandler: nil)
    }
}

func openInAppleMaps(address: String, withName locationName: String) {
    lazy var geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address) { placemarks, error in
        if let error = error {
            print(error.localizedDescription)
        }
        
        guard let placemark = placemarks?.first else {
            return
        }
        
        guard let lat = placemark.location?.coordinate.latitude else{return}
        
        guard let lon = placemark.location?.coordinate.longitude else{return}
        
        let coords = CLLocationCoordinate2DMake(lat, lon)
        
        let place = MKPlacemark(coordinate: coords)
        
        let mapItem = MKMapItem(placemark: place)
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit])
    }
}
