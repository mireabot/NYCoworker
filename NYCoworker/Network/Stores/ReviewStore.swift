//
//  ReviewStore.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/20/23.
//

import SwiftUI

@MainActor
class ReviewStore: ObservableObject {
  @Published var reviews: [Review] = []
  @Published var suggestionModel: LocationSuggestionModel = LocationSuggestionModel.empty
  
  func fetchReviews(completion: @escaping(Result<Void, Error>) -> Void) async {
    await ReviewService.shared.fetchReviewsForModeration(completion: { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.reviews = data
        }
        completion(.success(()))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
}
