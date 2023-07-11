//
//  AdminModerationSheetView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/18/23.
//

import SwiftUI

struct AdminModerationSheetView: View {
  @EnvironmentObject var reviewService: ReviewService
  @Binding var reviewData: Review
  @Binding var presented: Bool
  var body: some View {
    VStack {
      ReviewCard(variation: .full, data: reviewData).padding(.top, 15)
      
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
    AdminModerationSheetView(reviewData: .constant(Review.mock), presented: .constant(true))
  }
}

extension AdminModerationSheetView { // MARK: - Functions
  func publishReview(isPositive: Bool) {
    Task {
      if isPositive {
        await reviewService.publishReview(locationID: reviewData.locationID, reviewID: reviewData.id ?? "", completion: {
          reviewService.sendPushNotification(payloadDict: reviewService.positiveNotification(userToken: reviewData.userToken))
        })
      }
      
      else {
        await reviewService.deleteReview(reviewID: reviewData.id ?? "", completion: {
          reviewService.sendPushNotification(payloadDict: reviewService.negativeNotification(userToken: reviewData.userToken))
        })
      }
    }
  }
}
