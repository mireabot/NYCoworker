//
//  AdminNotificationView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/3/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AdminNotificationView: View {
  @Environment(\.dismiss) var makeDismiss
  @State private var reviewText: String = ""
  @State private var locationID: String = ""
  @State private var reviewerImage: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/nycoworker-10d04.appspot.com/o/UserImages%2FIMG_0812%202.jpeg?alt=media&token=9c09e090-b4f1-4b40-861b-11910d920632")!
  @State private var reviewerName: String = "Michael"
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(spacing: 20) {
        NYCTextField(title: "Review text", placeholder: "Enter text", text: $reviewText)
        NYCTextField(title: "Location ID", placeholder: "ID of locations", text: $locationID)
      }.padding([.leading,.trailing], 16)
    }
    .navigationBarBackButtonHidden()
    .toolbarBackground(.white, for: .navigationBar)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          makeDismiss()
        } label: {
          Resources.Images.Navigation.arrowBack
            .foregroundColor(Resources.Colors.primary)
        }
        
      }
      
      ToolbarItem(placement: .navigationBarLeading) {
        Text("Add review")
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 17))
      }
      
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          saveReview()
        } label: {
          Text("Submit")
            .foregroundColor(Resources.Colors.primary)
        }
      }
    }
  }
}

struct AdminNotificationView_Previews: PreviewProvider {
  static var previews: some View {
    AdminNotificationView()
  }
}

extension AdminNotificationView {
  func addReviewToFirestore(review: Review) {
    let db = Firestore.firestore()
    
    do {
      let reviewData = try Firestore.Encoder().encode(review)
      db.collection(Endpoints.reviews.rawValue).document().setData(reviewData)
    } catch let error {
      print("Error encoding location: \(error.localizedDescription)")
    }
  }
  
  func saveReview() {
    let review = Review(
      locationID: locationID,
      datePosted: Timestamp(date: Date()),
      dateVisited: Timestamp(date: Date()),
      text: reviewText,
      type: .pos,
      userName: reviewerName,
      userImage: reviewerImage,
      isLive: true,
      userToken: Resources.demoToken
    )
    addReviewToFirestore(review: review)
    reviewText = ""
    locationID = ""
  }
}
