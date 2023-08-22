//
//  NYCMiddleAlertView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/18/23.
//

import SwiftUI

struct NYCMiddleAlertView: View {
  var alertType: MiddleAlertType
  var action: () -> Void
    var body: some View {
      VStack(alignment: .center, spacing: 15) {
        Text(alertType.title)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 17))
        Text(alertType.text)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.regular(withSize: 15))
          .multilineTextAlignment(.center)
        
        Button {
          action()
        } label: {
          Text("Got it")
        }
        .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
        .padding([.leading,.trailing], 90)
        .padding(.top, 10)

      }
      .padding(15)
      .background(.white)
      .cornerRadius(15)
      .padding([.leading,.trailing])
    }
}

struct NYCMiddleAlertView_Previews: PreviewProvider {
    static var previews: some View {
      ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        NYCMiddleAlertView(alertType: .accountUpdated, action: {})
      }
    }
}
