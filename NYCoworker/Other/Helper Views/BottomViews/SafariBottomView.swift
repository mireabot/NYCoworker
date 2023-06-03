//
//  SafariBottomView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/3/23.
//

import SwiftUI

struct SafariBottomView: View {
  var url: URL
  var body: some View {
    VStack {
      GrabberView()
      SafariView(url: url)
        .cornerRadius(16)
    }
  }
}
