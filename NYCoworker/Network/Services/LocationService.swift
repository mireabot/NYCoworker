//
//  LocationService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/2/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

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
  
  ///Fetching all reviews which has ID matching with location's ID
  ///- parameter locationID: ID of location which searched in Reviews database
  ///- returns: set of reviews
  func fetchReviewsForLocation(locationID: String, completion: @escaping (Result<[Review], Error>) -> Void) async {
    do {
      var query: Query!
      query = db.collection(Endpoints.reviews.rawValue).order(by: "datePosted", descending: true).whereField("locationID", isEqualTo: locationID).whereField("isLive", isEqualTo: true)
      let docs = try await query.getDocuments()
      let fetchedReviews = docs.documents.compactMap { doc -> Review? in
        try? doc.data(as: Review.self)
      }
      completion(.success(fetchedReviews))
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
      try await db.collection(Endpoints.users.rawValue).document(userID).setData(["favoriteLocations": FieldValue.arrayUnion([locationID])], merge: true)
      completion(.success(()))
    } catch {
      completion(.failure(error))
      return
    }
  }
  
  /// Removing location for user's favorites list
  /// - Parameters:
  ///   - userID: ID of user which we modify
  ///   - locationID: ID of location which will be deleted
  func removeLocationFromFavorites(for userID: String, with locationID: String ,completion: @escaping(Result<Void, Error>) -> Void) async {
    do {
      try await db.collection(Endpoints.users.rawValue).document(userID).updateData([
        "favoriteLocations": FieldValue.arrayRemove([locationID])
      ])
      completion(.success(()))
    }
    catch {
      completion(.failure(error))
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
      let docs = try await db.collection(Endpoints.locations.rawValue).whereField("locationID", in: user.favoriteLocations).getDocuments()
      
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
  }
}

