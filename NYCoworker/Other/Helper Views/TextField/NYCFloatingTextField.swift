//
//  NYCFloatingTextField.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI

struct NYCFloatingTextField: View {
    let title: String
//    let header: String?
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Nil")
            TextField(title, text: $text)
                .frame(height: 50, alignment: .leading)
                .padding(.horizontal, 16)
                .textFieldStyle(PlainTextFieldStyle())
                .tint(Resources.Colors.primary)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(text.isEmpty ? Resources.Colors.lightGrey : Resources.Colors.primary, lineWidth: 1)
                )
        }
    }
}

#if DEBUG
struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        NYCFloatingTextField(title: "Your Email Address", text: .constant(""))
            .frame(width: 350, height: 60, alignment: .center)
    }
}
#endif

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
                .frame(height: 50, alignment: .leading)
                .padding(.horizontal, 16)
                .textFieldStyle(PlainTextFieldStyle())
                .tint(Resources.Colors.primary)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Resources.Colors.lightGrey, lineWidth: 1)
                )
            
        }
    }
}
