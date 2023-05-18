//
//  NYCReviewTypeBadge.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/18/23.
//

import SwiftUI

struct NYCReviewTypeBadge: View {
  var type: Review.ReviewType
    var body: some View {
      HStack(spacing: 5) {
        Image(type == .pos ? "review-pos" : "review-neg")
          .resizable()
          .frame(width: 16, height: 16)
          .foregroundColor(type == .pos ? Resources.Colors.actionGreen : Resources.Colors.actionRed)
        Text(type == .pos ? "Positive" : "Negative")
          .foregroundColor(type == .pos ? Resources.Colors.actionGreen : Resources.Colors.actionRed)
          .font(Resources.Fonts.regular(withSize: 15))
      }
      .padding(.vertical, 5)
      .padding(.horizontal, 8)
      .background(Color.white)
      .cornerRadius(10)
    }
}

struct NYCReviewTypeBadge_Previews: PreviewProvider {
    static var previews: some View {
      NYCReviewTypeBadge(type: .pos)
    }
}
