//
//  NYCAlertView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/18/23.
//

import SwiftUI

struct NYCAlertNotificationView: View {
  var alertStyle: TopAlertType
  var body: some View {
    HStack {
      HStack(alignment: .center, spacing: 10) {
        alertStyle.icon
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundColor(Color.white)
        Text(alertStyle.title)
          .foregroundColor(Color.white)
          .font(Resources.Fonts.medium(withSize: 17))
      }
      Spacer()
    }
    .padding(16)
    .background(Resources.Colors.customBlack)
    .cornerRadius(10)
    .padding([.leading,.trailing], 16)
  }
}

struct NYCAlertView_Previews: PreviewProvider {
  static var previews: some View {
    NYCAlertNotificationView(alertStyle: .removedFromFavorites)
  }
}
