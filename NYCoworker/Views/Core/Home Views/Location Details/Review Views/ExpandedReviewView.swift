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
    }
}


//@ViewBuilder
//func singleCardView(withData data: Review) -> some View {
//    VStack(alignment: .leading, spacing: 10) {
//        /// Header
//        HStack(alignment: .center, spacing: 10) {
//            Image("p1")
//                .resizable()
//                .frame(width: 50, height: 50)
//            Text("Saleb")
//                .foregroundColor(Resources.Colors.customBlack)
//                .font(Resources.Fonts.regular(withSize: 17))
//        }
//        ///Review badge
//        NYCRateBadge(badgeType: .expanded, reviewType: .postive)
//
//        /// Review info
//        HStack {
//            Text("Posted 30 Jan 2023 · Visited 10 Jan 2023")
//                .foregroundColor(Resources.Colors.darkGrey)
//                .font(Resources.Fonts.regular(withSize: 12))
//        }
//
//        ///Review text
//        HStack {
//            Text("jjjj")
//                .foregroundColor(Resources.Colors.customBlack)
//                .font(Resources.Fonts.regular(withSize: 13))
//        }
//    }
//    .padding([.leading,.trailing], 16)
//}
