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
    
    func fetchReviews(locationID: String, completion: @escaping () -> Void) async {
        do {
            var query: Query!
            query = db.collection(Endpoints.reviews.rawValue).whereField("id", isEqualTo: locationID).order(by: "datePosted", descending: true)
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
}
