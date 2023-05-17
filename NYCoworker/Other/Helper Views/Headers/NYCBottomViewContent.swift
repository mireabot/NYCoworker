//
//  NYCBottomViewContent.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/12/23.
//

import SwiftUI

struct NYCBottomViewContent: View {
  var content: BottomViewContent
    var body: some View {
      VStack(alignment: .leading, spacing: 10) {
        Text(content.header)
          .multilineTextAlignment(.leading)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 18))
        Text(content.text)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.regular(withSize: 15))
          .multilineTextAlignment(.leading)
      }
    }
}

//struct NYCBottomViewContent_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCBottomViewContent()
//    }
//}
