//
//  NYCFloatingTextField.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI

struct NYCFloatingTextField: View {
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private enum Field: Int, Hashable {
        case focused, unFocused
    }
    
    let title: String
    
    @Binding var text: String
    
    @State var isFocused: Bool = false
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    @FocusState private var focusField: Field?
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .focused($focusField, equals: .focused)
                .frame(height: 50, alignment: .leading)
                .padding(.horizontal, 16)
                .textFieldStyle(PlainTextFieldStyle())
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(text.isEmpty ? Resources.Colors.lightGrey : Resources.Colors.primary, lineWidth: 1)
                )
            
            Text(text.isEmpty ? title : title.withSingleLeadingSpace.withSingleTrailingSpace)
                .font(Resources.Fonts.regular(withSize: 17))
                .foregroundColor(text.isEmpty ? Color(.placeholderText) : Resources.Colors.primary)
            /// Do not replace `Color.white.opacity(0)` with `Color.clear`, it will result in unexpected behavior on changing animation state
                .background(text.isEmpty ? Color.white.opacity(0) : Color.white)
                .offset(y: text.isEmpty ? 0 : -33)
                .scaleEffect(text.isEmpty ? 1 : 0.75, anchor: .leading)
                .animation(.spring(response: 0.5, dampingFraction: 0.6),value: text)
                .padding(.horizontal, 16)
                .onTapGesture {
                    if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                        focusField = .focused
                    } else {
                        isFocused = true
                    }
                }
            
        }
        .padding(15)
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
