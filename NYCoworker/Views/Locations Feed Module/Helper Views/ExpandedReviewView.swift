//
//  ExpandedReviewView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/20/23.
//

import SwiftUI

struct ExpandedReviewView: View {
  enum ExpandedReviewViewType {
    case fullList
  }
  var type: ExpandedReviewViewType?
  @EnvironmentObject private var model: ReviewService
  var body: some View {
    switch type {
    case .fullList:
      fullListView()
    case .none:
      EmptyView()
    }
  }
  
  @ViewBuilder
  func fullListView() -> some View {
    VStack {
      NYCBottomSheetHeader(title: "All reviews").paddingForHeader()
      ScrollView(.vertical, showsIndicators: true) {
        VStack {
          ForEach(model.reviews,id: \.datePosted) { review in
            ReviewCard(variation: .full, data: review)
          }
        }
        .padding([.leading,.trailing], 16)
        .padding(.top, 10)
      }
    }
    .background(Color.white)
    .cornerRadius(16, corners: [.topLeft,.topRight])
  }
}
