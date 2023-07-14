//
//  NavigationDestinations.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/28/23.
//

import Foundation

@MainActor
final class NavigationDestinations : ObservableObject {
  @Published var isPresentingFavourites: Bool = false
  @Published var isPresentingNotifications: Bool = false
  @Published var isPresentingReviews: Bool = false
  @Published var isPresentingMap: Bool = false
  @Published var isPresentingReviewSubmission: Bool = false
  @Published var isPresentingFeedbackSubmission: Bool = false
  @Published var isPresentingAccountDelete: Bool = false
}
