//
//  EmptyPromoBannerView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/10/23.
//

import SwiftUI
import Shimmer

struct EmptyPromoBannerView: View {
    var body: some View {
      ZStack(alignment: .bottomTrailing) {
        HStack {
          VStack(alignment: .leading, spacing: 10) {
            Text("Discover Refreshing Summer Spots: With Ice and Relax")
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(Resources.Fonts.medium(withSize: 17))
              .foregroundColor(.white)
          }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Resources.Colors.primary)
        .cornerRadius(15)
      }
      .clipped()
      .padding([.leading,.trailing], 16)
      .redacted(reason: .placeholder)
      .shimmering(active: true, duration: 1.5, bounce: false)
    }
}

struct EmptyPromoBannerView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPromoBannerView()
    }
}
