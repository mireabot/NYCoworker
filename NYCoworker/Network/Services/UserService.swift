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
    @Published var user: [User] = []
    
    func fetchUser(documentId: String, completion: @escaping () -> Void) async {
        do {
            var query: Query!
            query = db.collection(Endpoints.users.rawValue)
            let docs = try await query.whereField("userID", isEqualTo: documentId).getDocuments()
            let fetchedUser = docs.documents.compactMap { doc -> User? in
                try? doc.data(as: User.self)
            }
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

