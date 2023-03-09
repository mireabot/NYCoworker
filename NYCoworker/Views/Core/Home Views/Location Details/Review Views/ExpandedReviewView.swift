//
//  ExpandedReviewView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/20/23.
//

import SwiftUI

struct ExpandedReviewView: View {
    enum ExpandedReviewViewType {
        case singleCard
        case fullList
    }
    var data: ReviewModel
    var type: ExpandedReviewViewType?
    var body: some View {
        ActionSheetView(bgColor: .white) {
            switch type {
            case .singleCard:
                singleCardView(withData: data)
            case .fullList:
                fullListView()
            case .none:
                ErrorEmptyView()
            }
        }
    }
    @ViewBuilder
    func singleCardView(withData data: ReviewModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            /// Header
            HStack(alignment: .center, spacing: 10) {
                data.userIcon
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(data.userName)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 17))
            }
            ///Review badge
            NYCRateBadge(badgeType: .expanded, reviewType: .postive)
            
            /// Review info
            HStack {
                Text("Posted 30 Jan 2023 · Visited 10 Jan 2023")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 12))
            }
            
            ///Review text
            HStack {
                Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 13))
            }
        }
        .padding(16)
    }
    
    @ViewBuilder
    func fullListView() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack {
                ForEach(reviewData) { review in
                    ReviewCard(variation: .full, data: review)
                }
            }
            .padding([.leading,.trailing], 16)
            .padding(.top, 10)
        }
    }
}
    //struct ExpandedReviewView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        ExpandedReviewView()
    //    }
    //}
