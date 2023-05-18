//
//  NYCBottomSheetHeader.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/26/23.
//

import SwiftUI

struct NYCBottomSheetHeader: View {
  var title: String
  var body: some View {
    VStack(alignment: .center) {
      Text(title)
        .font(Resources.Fonts.medium(withSize: 17))
      Divider()
    }
  }
}

struct NYCHeader: View {
  enum HeaderStyle {
    case center
    case leading
  }
  var title: String
  var headerType: HeaderStyle?
  var body: some View {
    switch headerType {
    case .center:
      VStack {
        Text(title)
          .font(Resources.Fonts.medium(withSize: 17))
      }
    case .leading:
      HStack {
        Text(title)
          .font(Resources.Fonts.medium(withSize: 22))
        Spacer()
      }
    case .none:
      HStack {
        Text(title)
          .font(Resources.Fonts.medium(withSize: 22))
        Spacer()
      }
    }
  }
}
