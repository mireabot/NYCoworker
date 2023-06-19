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
  var body: some View {
    VStack {
      GrabberView()
      VStack {
        ReviewCard(variation: .full, data: reviewData).padding(.top, 15)
        
        HStack {
          Button {
            publishReview()
          } label: {
            Text("Publish")
          }
          .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
          
          NYCActionButton(action: {
            
          }, text: "Deny",buttonStyle: .system)
          
        }
      }
      .padding(.bottom, UIScreen.main.bounds.size.height == 667 ? 10 : 50)
      .padding([.leading,.trailing], 16)
      .background(.white)
      .cornerRadius(16, corners: [.topLeft,.topRight])
    }
  }
}

struct AdminModerationSheetView_Previews: PreviewProvider {
  static var previews: some View {
    AdminModerationSheetView(reviewData: .constant(Review.mock))
  }
}

extension AdminModerationSheetView { // MARK: - Functions
  func publishReview() {
    Task {
      await reviewService.publishReview(locationID: reviewData.locationID, reviewID: reviewData.id ?? "", completion: {
        sendPushNotification(payloadDict: positiveNotification(userToken: reviewData.userToken))
      })
    }
  }
  
  func sendPushNotification(payloadDict: [String: Any]) {
    let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("key=\(Resources.messagingKey)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: payloadDict, options: [])
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print(error ?? "")
        return
      }
      if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
        print(response ?? "")
      }
      print("Notfication sent successfully.")
      let responseString = String(data: data, encoding: .utf8)
      print(responseString ?? "")
    }
    task.resume()
  }
  
  func positiveNotification(userToken: String?) -> [String: Any] {
    return ["to": "\(userToken ?? Resources.demoToken)","notification": ["title":"Congrats! Your review is live🌐","body":"Thank you for improving our professional community!","sound":"default"] as [String : Any]]
  }
}
