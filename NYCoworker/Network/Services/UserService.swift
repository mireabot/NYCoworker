//
//  UserService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/1/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class UserService: ObservableObject {
    private var db = Firestore.firestore()
    @Published var user: User = User(userID: "", avatarURL: URL(fileURLWithPath: ""), name: "", occupation: "", favoriteLocations: [])
    
    ///Fetching user data based on save ID
    ///- parameter documentId: User's ID which stored localy in app defaults
    ///- returns: single User model with fetched data
    func fetchUser(documentId: String, completion: @escaping () -> Void) async {
        do {
            let fetchedUser = try await db.collection(Endpoints.users.rawValue).document(documentId).getDocument(as: User.self)
            await MainActor.run(body: {
                user = fetchedUser
                completion()
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

