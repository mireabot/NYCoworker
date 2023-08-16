//
//  NYCResizableTextField.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/21/23.
//

import SwiftUI

struct NYCResizableTextField: View {
  @Binding var message: String
  var characterLimit: Int
  var placeHolder: String
  var body: some View {
    VStack() {
      HStack(spacing: 8) {
        withAnimation(.easeInOut) {
          TextField("", text: $message, axis: .vertical)
            .font(Resources.Fonts.regular(withSize: 17))
            .tint(Resources.Colors.primary)
            .keyboardType(.alphabet)
            .autocorrectionDisabled(true)
            .onChange(of: message) { newValue in
              if newValue.count > characterLimit {
                message = String(newValue.prefix(characterLimit))
              }
            }
            .placeholder(when: message.isEmpty) {
              Text(placeHolder)
                .foregroundColor(Resources.Colors.darkGrey)
                .font(Resources.Fonts.regular(withSize: 15))
            }
            .lineLimit(...7)
        }
      }
      .padding(.vertical, 15)
      .padding(.horizontal, 12)
      .background(Resources.Colors.customGrey)
      .cornerRadius(10)
      .padding(.top, 15)
      
      HStack {
        Text("\(characterLimit - message.count) characters left")
          .foregroundColor(message.count == characterLimit ? Resources.Colors.actionRed : Resources.Colors.darkGrey)
          .font(Resources.Fonts.regular(withSize: 14))
        Spacer()
        Button {
          message = ""
        } label: {
          Text("Clear")
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 14))
        }
        
      }
    }
  }
}

//struct NYCResizableTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCResizableTextField()
//    }
//}
