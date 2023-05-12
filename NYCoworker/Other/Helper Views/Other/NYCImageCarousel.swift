//
//  NYCImageCarousel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct NYCImageCarousel: View {
  @State private var currentIndex: Int = 0
  var imageUrls: [URL]
  var body: some View {
    VStack {
      TabView(selection: $currentIndex) {
        ForEach(imageUrls.indices, id: \.self) { index in
          WebImage(url: imageUrls[index]).placeholder {
            Image("load")
              .resizable()
          }
          .resizable()
          .aspectRatio(contentMode: .fill)
          .tag(index)
        }
      }
      .tabViewStyle(PageTabViewStyle())
    }
  }
}
