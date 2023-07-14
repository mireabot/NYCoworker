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
  @Published var user: User = User(userID: "", avatarURL: URL(fileURLWithPath: ""), name: "", occupation: "", favoriteLocations: [], token: "")
  
  /// Fetching user data based on save ID
  ///- parameter documentId: User's ID which stored localy in app defaults
  ///- returns: single User model with fetched data
  func fetchUser(documentId: String, completion: @escaping () -> Void) {
    let docRef = db.collection(Endpoints.users.rawValue).document(documentId)
    docRef.addSnapshotListener { documentSnapshot, error in
      guard let document = documentSnapshot else {
        print("Document does not exist")
        return
      }
      
      if let error = error {
        print("Error fetching document: \(error.localizedDescription)")
        return
      }
      
      if let data = document.data() {
        self.user = try! Firestore.Decoder().decode(User.self, from: data)
        completion()
      } else {
        print("Document data is empty")
      }
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
    db.collection(Endpoints.users.rawValue).document(user).updateData(["token": token])
  }
  
  /// Creates feedback about app usage or location edits
  ///- Parameters:
  ///   - userID: User's ID who sent feedback
  ///   - message: Text of feedback
  func createFeedback(withID userID: String, withMessage message: String, completion: @escaping () -> Void, errorCompletion: @escaping (Error) -> Void) async {
    do {
      try await db.collection(Endpoints.feedback.rawValue).document().setData([
        "feedbackID": randomString(length: 5),
        "userID": userID,
        "message": message,
        "datePosted": Date(),
        "reportType": "",
        "locationID": ""
      ])
      completion()
    }
    catch {
      errorCompletion(error)
    }
  }
  
  func randomString(length: Int) -> String {
    let letters = "0123456789QWERTYUIOPASDFGHJKLZXCVBNM"
    return String((0..<length).map{ _ in letters.randomElement()! })
  }
}
