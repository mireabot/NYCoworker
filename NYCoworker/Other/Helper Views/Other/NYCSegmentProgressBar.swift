//
//  NYCSegmentProgressBar.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/10/23.
//

import SwiftUI

struct NYCSegmentProgressBar: View {
  var value: Int
  var maximum: Int = 5
  var height: CGFloat = 10
  var spacing: CGFloat = 2
  var selectedColor: Color = Resources.Colors.primary
  var unselectedColor: Color = Resources.Colors.customGrey

  var body: some View {
    HStack(spacing: spacing) {
      ForEach(0 ..< maximum) { index in
        Rectangle()
          .foregroundColor(index < self.value ? self.selectedColor : self.unselectedColor)
      }
    }
    .frame(maxHeight: height)
    .clipShape(Capsule(style: .continuous))
  }
}

