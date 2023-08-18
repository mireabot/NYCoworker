//
//  LocationsViewModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/18/23.
//

import SwiftUI

@MainActor
class LocationsHomeViewVM: ObservableObject {
  @Published var locationsData : [Location] = []
  
  var hotels: [Location] {
    return locationsData.filter({ $0.locationType == .hotel})
  }
  
  var libraries: [Location] {
    return locationsData.filter({ $0.locationType == .library})
  }
  
  var publicSpaces: [Location] {
    return locationsData.filter({ $0.locationType == .publicSpace})
  }
  
  var cafes: [Location] {
    return locationsData.filter({ $0.locationType == .cafe})
  }
}
