//
//  ExpandedReviewView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/20/23.
//

import SwiftUI

struct ReviewListView: View {
  @EnvironmentObject private var model: LocationStore
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        VStack {
          ForEach(model.reviews,id: \.datePosted) { review in
            NYCReviewCard(variation: .full, data: review)
          }
        }
        .padding([.leading,.trailing], 16)
      }
      .padding(.top, 10)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Reviews")
            .font(Resources.Fonts.medium(withSize: 17))
        }
      }
    }
  }
}
