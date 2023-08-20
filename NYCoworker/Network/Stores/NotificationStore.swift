//
//  NotificationStore.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/19/23.
//

import SwiftUI

@MainActor
class NotificationStore: ObservableObject {
  @Published var notifications: [Notification] = []
  
  func fetchNotifications(completion: @escaping(Result<Void, Error>) -> Void) async {
    await NotificationService.shared.fetchNotifications(completion: { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.notifications = data
        }
        completion(.success(()))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
}
