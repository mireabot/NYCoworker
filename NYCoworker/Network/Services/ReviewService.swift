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
  @Published var suggestionModel = LocationSuggestionModel.empty
  
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
  ///   - locationID: ID of location for which review will be published
  ///   - reviewID: ID of review which will be visible for public
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
  
  func sendLocationSuggestion(with model: LocationSuggestionModel, completion: @escaping () -> Void) async {
    do {
      let data = try Firestore.Encoder().encode(model)
      try await db.collection(Endpoints.suggestions.rawValue).document().setData(data)
      await MainActor.run(body: {
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
  
  ///Send push notification to user whos review is approved
  ///- Parameters:
  ///   - payloadDict: Dictionary of message to send and token of recepient user
  func sendPushNotification(payloadDict: [String: Any]) {
    let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("key=\(Resources.messagingKey)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: payloadDict, options: [])
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print(error ?? "")
        return
      }
      if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
        print(response ?? "")
      }
      print("Notfication sent successfully.")
      let responseString = String(data: data, encoding: .utf8)
      print(responseString ?? "")
    }
    task.resume()
  }
  
  /// Dictionary for positive push upon review moderation
  ///- Parameters:
  ///  - userToken: token of user who will receive push
  func positiveNotification(userToken: String?) -> [String: Any] {
    return ["to": "\(userToken ?? Resources.demoToken)","notification": ["title":"Congrats! Your review is live🌐","body":"Thank you for improving our professional community!","sound":"default"] as [String : Any]]
  }
  
  /// Dictionary for negative push upon review moderation
  ///- Parameters:
  ///  - userToken: token of user who will receive push
  func negativeNotification(userToken: String?) -> [String: Any] {
    return ["to": "\(userToken ?? Resources.demoToken)","notification": ["title":"Your review failed moderation🥲","body":"We won't make it live. But you can make another one!","sound":"default"] as [String : Any]]
  }
  
  func deleteReview(reviewID: String, completion: @escaping () -> Void) async {
    do {
      try await db.collection(Endpoints.reviews.rawValue).document(reviewID).delete()
      await MainActor.run(body: {
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
}
