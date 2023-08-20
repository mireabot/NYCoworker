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
  @StateObject private var reviewStore = ReviewStore()
  @State private var showModerationSheet = false
  @State var passingReviewData : Review = Review.mock
  @State private var sheetContentHeight = CGFloat(0)
    var body: some View {
      ScrollView(.vertical, showsIndicators: true) {
        reviewsList()
      }
      .sheet(isPresented: $showModerationSheet, content: {
        AdminModerationSheetView(reviewData: passingReviewData, presented: $showModerationSheet)
          .background {
            GeometryReader { proxy in
              Color.clear
                .task {
                  sheetContentHeight = proxy.size.height
                }
            }
          }
          .presentationDetents([.height(sheetContentHeight)])
          .presentationDragIndicator(.visible)
      })
      .padding([.leading,.trailing], 16)
      .task {
        await fetchAllReviews()
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
          NYCEmptyView(type: .noReviews)
            .redacted(reason: .placeholder)
            .shimmering(active: true)
        }
      }
    }
    else {
      if reviewStore.reviews.isEmpty {
        NYCEmptyView(type: .moderationReviews)
      }
      else {
        LazyVStack(alignment: .center, spacing: 10) {
          ForEach(reviewStore.reviews,id: \.datePosted){ reviewData in
            NYCReviewCard(variation: .full, data: reviewData)
              .onTapGesture {
                self.passingReviewData = reviewData
                showModerationSheet.toggle()
              }
          }
        }
      }
    }
  }
}

extension AdminModerationView { // MARK: - Functions
  func fetchAllReviews() async {
    await reviewStore.fetchReviews(completion: { result in
      switch result {
      case .success:
        print("Reviews are fetched \(reviewStore.reviews.count)")
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }
}
