//
//  NYCFloatingTextField.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI

struct NYCTextField: View {
  let title: String
  var placeholder: String?
  @Binding var text: String
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 15))
      
      TextField(placeholder ?? "", text: $text)
        .font(Resources.Fonts.regular(withSize: 17))
        .frame(height: 50, alignment: .leading)
        .padding(.horizontal, 16)
        .textFieldStyle(PlainTextFieldStyle())
        .tint(Resources.Colors.primary)
        .keyboardType(.alphabet)
        .autocorrectionDisabled(true)
        .submitLabel(.done)
        .background(
          RoundedRectangle(cornerRadius: 16)
            .strokeBorder(Resources.Colors.lightGrey, lineWidth: 1)
        )
    }
  }
}
