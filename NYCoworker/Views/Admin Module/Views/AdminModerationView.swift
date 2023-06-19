//
//  AdminModerationView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/18/23.
//

import SwiftUI
import Shimmer
import PopupView

struct AdminModerationView: View {
  @Environment(\.dismiss) var makeDismiss
  @State private var isLoading = true
  @StateObject var reviewService = ReviewService()
  @State private var showModerationSheet = false
  @State var passingReviewData : Review = Review.mock
    var body: some View {
      ScrollView(.vertical, showsIndicators: true) {
        reviewsList()
      }
      .padding([.leading,.trailing], 16)
      .popup(isPresented: $showModerationSheet, view: {
        AdminModerationSheetView(reviewData: $passingReviewData).environmentObject(reviewService)
      }, customize: {
        $0
          .type(.toast)
          .backgroundColor(Color.black.opacity(0.3))
          .position(.bottom)
          .closeOnTap(false)
          .closeOnTapOutside(false)
          .dragToDismiss(true)
          .animation(.spring(response: 0.4, blendDuration: 0.2))
      })
      .task {
        await reviewService.fetchReviewsForModeration(completion: {
          isLoading = false
        })
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
          Text("Publish reviews")
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 17))
        }
      }
    }
}

struct AdminModerationView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        AdminModerationView()
      }
    }
}

extension AdminModerationView { // MARK: - View components
  @ViewBuilder
  func reviewsList() -> some View {
    if isLoading {
      LazyVStack(alignment: .center, spacing: 10) {
        ForEach(0..<4) { _ in
          ReviewEmptyView()
            .redacted(reason: .placeholder)
            .shimmering(active: true)
        }
      }
    }
    else {
      LazyVStack(alignment: .center, spacing: 10) {
        ForEach(reviewService.reviews,id: \.datePosted){ reviewData in
          ReviewCard(variation: .full, data: reviewData)
            .onTapGesture {
              self.passingReviewData = reviewData
              showModerationSheet.toggle()
            }
        }
      }
    }
  }
}
