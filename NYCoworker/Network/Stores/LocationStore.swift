//
//  LocationStore.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/19/23.
//

import SwiftUI

@MainActor
class LocationStore: ObservableObject {
  
  @Published var locations: [Location] = []
  @Published var reviews: [Review] = []
  @Published var favoriteLocations: [Location] = []
  
  var hotels: [Location] {
    return locations.filter({ $0.locationType == .hotel})
  }
  
  var libraries: [Location] {
    return locations.filter({ $0.locationType == .library})
  }
  
  var publicSpaces: [Location] {
    return locations.filter({ $0.locationType == .publicSpace})
  }
  
  var cafes: [Location] {
    return locations.filter({ $0.locationType == .cafe})
  }
  
  func fetchLocations(completion: @escaping(Result<Void, Error>) -> Void) async {
    await LocationService.shared.fetchLocations(completion: { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.locations = data
          completion(.success(()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  func fetchReviews(for id: String, completion: @escaping(Result<Void, Error>) -> Void) async {
    await LocationService.shared.fetchReviewsForLocation(locationID: id, completion: { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.reviews = data
          completion(.success(()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  func fetchFavoriteLocations(for user: User, completion: @escaping(Result<Void, Error>) -> Void) async {
    await LocationService.shared.fetchFavoriteLocations(for: user, completion: { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.favoriteLocations = data
          completion(.success(()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
}
