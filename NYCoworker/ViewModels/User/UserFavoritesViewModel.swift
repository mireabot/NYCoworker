//
//  UserFavoritesViewModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/18/23.
//

import SwiftUI

@MainActor
class UserFavoritesViewModel: ObservableObject {
  @Published var userFavoritesLocations: [Location] = []
}
