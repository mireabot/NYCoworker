//
//  NYCSettingsCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI

struct NYCSettingsCard: View {
  var type: SettingsData
  var action: () -> Void
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        HStack(alignment: .center, spacing: 10) {
          type.icon
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Resources.Colors.customBlack)
          Text(type.title)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.regular(withSize: 15))
        }
        
        Spacer()
        
        Resources.Images.Navigation.chevronRight
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(Resources.Colors.darkGrey)
      }
      .padding(15)
      .background(Resources.Colors.customGrey)
      .cornerRadius(10)
    }
    .buttonStyle(NYCButtonStyle())
    
  }
}

struct NYCSettingsCard_Previews: PreviewProvider {
  static var previews: some View {
    NYCSettingsCard(type: .locationUpdates, action: {})
  }
}
