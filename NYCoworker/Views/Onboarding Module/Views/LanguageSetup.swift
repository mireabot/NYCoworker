//
//  LanguageSetup.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/26/23.
//

import SwiftUI

struct LanguageSetup: View {
  var body: some View {
    VStack {
      NYCBottomSheetHeader(title: "Choose your app language")
        .padding(.top, 20)
      
      VStack {
        ForEach(appLanguages) { appLanguage in
          VStack(spacing: 20) {
            LanguageCard(data: appLanguage)
          }
        }
      }
      .padding(.top, 20)
      
      Spacer()
      
      Button {
        
      } label: {
        Text("Continue with English")
          .foregroundColor(.white)
          .font(Resources.Fonts.regular(withSize: 17))
          .frame(width: UIScreen.main.bounds.width - 16, height: 48)
      }
      .background(Resources.Colors.primary)
      .cornerRadius(10)
      .padding(.bottom, 10)
    }
  }
}

struct LanguageSetup_Previews: PreviewProvider {
  static var previews: some View {
    LanguageSetup()
  }
}
