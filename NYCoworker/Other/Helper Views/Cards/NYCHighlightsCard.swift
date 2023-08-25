//
//  NYCHighlightsCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/24/23.
//

import SwiftUI

struct NYCHighlightsCard: View {
  var action: () -> Void
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        HStack(spacing: 5) {
          Resources.Images.Navigation.highlights
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Resources.Colors.darkGrey)
          Text("Check location highlights")
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.regular(withSize: 15))
        }
        Spacer()
        
        Resources.Images.Navigation.chevronRight
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(Resources.Colors.darkGrey)
        
      }
    }
  }
}

struct NYCHighlightsCard_Previews: PreviewProvider {
  static var previews: some View {
    NYCHighlightsCard(action: {})
  }
}
