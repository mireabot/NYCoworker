//
//  AdminModerationSheetView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/18/23.
//

import SwiftUI

struct AdminModerationSheetView: View {
  @StateObject private var reviewStore = ReviewStore()
  var reviewData: Review
  @Binding var presented: Bool
  var body: some View {
    VStack {
      NYCReviewCard(variation: .full, data: reviewData).padding(.top, 15)
      
      HStack {
        Button {
          publishReview(isPositive: true)
          presented = false
        } label: {
          Text("Publish")
        }
        .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
        
        NYCActionButton(action: {
          publishReview(isPositive: false)
          presented = false
        }, text: "Deny",buttonStyle: .system)
        
      }
    }
    .padding(.bottom, 20)
    .padding([.leading,.trailing], 16)
    .background(.white)
  }
}

struct AdminModerationSheetView_Previews: PreviewProvider {
  static var previews: some View {
    AdminModerationSheetView(reviewData: Review.mock, presented: .constant(true))
  }
}

extension AdminModerationSheetView { // MARK: - Functions
  func publishReview(isPositive: Bool) {
    Task {
      if isPositive {
        await ReviewService.shared.publishReview(locationID: reviewData.locationID, reviewID: reviewData.id ?? "", completion: { result in
          switch result {
          case .success:
            print("Review was published")
            ReviewService.shared.sendPushNotification(payloadDict: ReviewService.shared.positiveNotification(userToken: reviewData.userToken))
          case .failure(let error):
            print(error.localizedDescription)
          }
        })
      }
      
      else {
        await ReviewService.shared.deleteReview(reviewID: reviewData.id ?? "", completion: { result in
          switch result {
          case .success:
            print("Review was deleted")
            ReviewService.shared.sendPushNotification(payloadDict: ReviewService.shared.negativeNotification(userToken: reviewData.userToken))
          case .failure(let error):
            print(error.localizedDescription)
          }
        })
      }
    }
  }
}
