//
//  ReviewService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/31/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class ReviewService: ObservableObject {
  private var db = Firestore.firestore()
  @Published var reviews: [Review] = []
  
  ///Fetching all reviews which has ID matching with location's ID
  ///- parameter locationID: ID of location which searched in Reviews database
  ///- returns: set of reviews
  func fetchReviews(locationID: String, completion: @escaping () -> Void) async {
    do {
      var query: Query!
      query = db.collection(Endpoints.reviews.rawValue).order(by: "datePosted", descending: true).whereField("locationID", isEqualTo: locationID).whereField("isLive", isEqualTo: true)
      let docs = try await query.getDocuments()
      let fetchedReviews = docs.documents.compactMap { doc -> Review? in
        try? doc.data(as: Review.self)
      }
      await MainActor.run(body: {
        reviews = fetchedReviews
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
  
  ///Create review based on user input
  ///- Parameters:
  ///   - review: Template of review object to send
  ///   - location: Data about location which will be reviewed
  func createReview(from review: Review, location: Location, completion: @escaping () -> Void) async {
    do {
      let reviewData = try Firestore.Encoder().encode(review)
      try await db.collection(Endpoints.reviews.rawValue).document().setData(reviewData)
      //try await db.collection(Endpoints.locations.rawValue).document(location.locationID).setData(["reviews": location.reviews + 1], merge: true)
      await MainActor.run(body: {
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
  
  ///Fetching all reviews which are not yet moderated
  ///- returns: set of reviews
  func fetchReviewsForModeration(completion: @escaping () -> Void) async {
    do {
      var query: Query!
      query = db.collection(Endpoints.reviews.rawValue).order(by: "datePosted", descending: true).whereField("isLive", isEqualTo: false)
      let docs = try await query.getDocuments()
      let fetchedReviews = docs.documents.compactMap { doc -> Review? in
        try? doc.data(as: Review.self)
      }
      await MainActor.run(body: {
        reviews = fetchedReviews
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
  
  ///Create review based on user input
  ///- Parameters:
  ///   - location: Data about location which will be fetched
  func publishReview(locationID: String, reviewID: String, completion: @escaping () -> Void) async {
    do {
      let locationDoc = try await db.collection(Endpoints.locations.rawValue).document(locationID).getDocument(as: Location.self)
      //Update temp value with fetched data about location
      let reviewsCount = locationDoc.reviews
      try await db.collection(Endpoints.locations.rawValue).document(locationID).setData(["reviews": reviewsCount + 1], merge: true)
      try await db.collection(Endpoints.reviews.rawValue).document(reviewID).setData(["isLive": true], merge: true)
      await MainActor.run(body: {
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
}
