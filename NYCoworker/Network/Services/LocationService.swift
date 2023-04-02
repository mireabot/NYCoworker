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

class LocationService: ObservableObject {
    private var db = Firestore.firestore()
    @Published var locations: [Location] = []
    
    func fetchLoactions(completion: @escaping () -> Void) async {
        do {
            var query: Query!
            query = db.collection(Endpoints.locations.rawValue)
            let docs = try await query.getDocuments()
            let fetchedLocations = docs.documents.compactMap { doc -> Location? in
                try? doc.data(as: Location.self)
            }
            await MainActor.run(body: {
                locations = fetchedLocations
                completion()
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

