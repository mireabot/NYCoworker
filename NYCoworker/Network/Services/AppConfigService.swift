//
//  AppConfigService.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/15/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct AppConfig: Codable {
  var maintainceMode: Bool
}

class AppConfigService: ObservableObject {
  private var db = Firestore.firestore()
  @Published var congig : [AppConfig] = []
  
  ///Fetching user data based on save ID
  ///- parameter documentId: User's ID which stored localy in app defaults
  ///- returns: single User model with fetched data
  func fetchConfig() {
    db.collection("AppConfig").addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      
      self.congig = documents.compactMap { queryDocumentSnapshot -> AppConfig? in
        return try? queryDocumentSnapshot.data(as: AppConfig.self)
      }
    }
  }
}

