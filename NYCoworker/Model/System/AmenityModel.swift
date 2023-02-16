//
//  AmenityModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/16/23.
//

import SwiftUI


struct AmenityModel: Identifiable {
    var id: Int
    var icon: Image
    var title: String
}

let amenityData = [
    AmenityModel(id: 0, icon: LocationR.Amenities.wifi, title: "Wi-Fi"),
    AmenityModel(id: 1, icon: LocationR.Amenities.ac, title: "A/C"),
    AmenityModel(id: 2, icon: LocationR.Amenities.charge, title: "Charging"),
    AmenityModel(id: 3, icon: LocationR.Amenities.meeting, title: "Meeting rooms"),
]


struct WorkingHoursModel: Identifiable {
    var id: Int
    var day: String
    var hours: String
}

let hoursData = [
    WorkingHoursModel(id: 0, day: "Monday", hours: "10AM - 9PM"),
    WorkingHoursModel(id: 1, day: "Tuesday", hours: "10AM - 9PM"),
    WorkingHoursModel(id: 2, day: "Wendsday", hours: "10AM - 9PM"),
    WorkingHoursModel(id: 3, day: "Thursday", hours: "10AM - 9PM"),
    WorkingHoursModel(id: 4, day: "Friday", hours: "10AM - 9PM"),
    WorkingHoursModel(id: 5, day: "Saturday", hours: "10AM - 9PM"),
    WorkingHoursModel(id: 6, day: "Sunday", hours: "10AM - 9PM"),
]
