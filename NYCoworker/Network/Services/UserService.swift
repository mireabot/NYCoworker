//
//  UserService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/1/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

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
    
    func logIn(withEmail email: String, withPass password: String, completion: @escaping () -> Void, completion2: @escaping (Error) -> Void) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            completion()
        }
        catch {
            completion2(error)
        }
    }
    
    func addToken(forUser user: String, token: String) {
        db.collection("User").document(user).updateData(["token": token])
    }
}

