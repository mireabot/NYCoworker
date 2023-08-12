//
//  LocationSuggestionModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/10/23.
//

import Foundation

struct LocationSuggestionModel: Codable {
  var locationName: String
  var locationAddress: String
  var locationAmenities: String
  var userID: String
  var userComment: String
  var userToken: String
  
  static let empty = LocationSuggestionModel(locationName: "", locationAddress: "", locationAmenities: "", userID: "", userComment: "", userToken: "")
}
