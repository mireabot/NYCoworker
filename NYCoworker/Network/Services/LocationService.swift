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
    @Published var favoriteLocations : [Location] = []
    
    ///Fetching all locations from Firebase
    ///- returns: set of locations
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
    ///Adding location ID to favoriteLocations array in User model
    ///- parameter locationID: ID of location which will be added
    ///- parameter userID: ID of User which added location to favorites
    ///- warning: Use completion for action after data loaded
    func addFavoriteLocation(locationID: String, userID: String, completion: @escaping () -> Void) async throws {
        do {
            try await db.collection("User").document(userID).setData(["favoriteLocations": FieldValue.arrayUnion([locationID])], merge: true)
            completion()
        } catch {
            throw error
        }
    }
    ///Fetching favorite locations based on user's set of favorite locations
    ///- parameter user: User model which will show array of favorite locations
    ///- warning: Use completion for action after data loaded
    ///- returns: favoriteLocations array in locationService class
    func fetchFavoriteLocations(for user: User, completion: @escaping () -> Void) async {
        guard !user.favoriteLocations.isEmpty else {
            completion()
            return
        }
        do {
            let db = Firestore.firestore()
            let locationsCollection = db.collection("Locations")
            
            let docs = try await locationsCollection.whereField("locationID", in: user.favoriteLocations).getDocuments()
            
            let fetchedFavs = docs.documents.compactMap { doc -> Location? in
                try? doc.data(as: Location.self)
            }
            await MainActor.run(body: {
                favoriteLocations = fetchedFavs
                completion()
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

