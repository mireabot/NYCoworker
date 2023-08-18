//
//  LocationService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/2/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import MapKit

@MainActor
class LocationService {
  private var db = Firestore.firestore()
  
  static let shared = LocationService()
  
  ///Fetching all locations from Firebase
  ///- returns: set of locations
  func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) async {
    do {
      var query: Query!
      query = db.collection(Endpoints.locations.rawValue).order(by: "locationPriority", descending: true)
      let docs = try await query.getDocuments()
      let fetchedLocations = docs.documents.compactMap { doc -> Location? in
        try? doc.data(as: Location.self)
      }
      completion(.success(fetchedLocations))
    }
    catch {
      completion(.failure(error))
    }
  }
  
  ///Adding location ID to favoriteLocations array in User model
  ///- parameter locationID: ID of location which will be added
  ///- parameter userID: ID of User which added location to favorites
  ///- warning: Use completion for action after data loaded
  func addFavoriteLocation(locationID: String, userID: String, completion: @escaping (Result<Void, Error>) -> Void) async {
    do {
      try await db.collection("User").document(userID).setData(["favoriteLocations": FieldValue.arrayUnion([locationID])], merge: true)
      completion(.success(()))
    } catch {
      completion(.failure(error))
      return
    }
  }
  
  ///Fetching favorite locations based on user's set of favorite locations
  ///- parameter user: User model which will show array of favorite locations
  ///- warning: Use completion for action after data loaded
  ///- returns: favoriteLocations array in locationService class
  func fetchFavoriteLocations(for user: User, completion: @escaping (Result<[Location], Error>) -> Void) async {
    guard !user.favoriteLocations.isEmpty else {
      completion(.success([]))
      return
    }
    do {
      let locationsCollection = db.collection("Locations")
      
      let docs = try await locationsCollection.whereField("locationID", in: user.favoriteLocations).getDocuments()
      
      let fetchedFavs = docs.documents.compactMap { doc -> Location? in
        try? doc.data(as: Location.self)
      }
      completion(.success(fetchedFavs))
    }
    catch {
      completion(.failure(error))
      return
    }
  }
  
  func setError(_ error: Error) {
    print("DEBUG: \(firestoreError(forError: error))")
    //errorMessage = firestoreError(forError: error)
  }
}

