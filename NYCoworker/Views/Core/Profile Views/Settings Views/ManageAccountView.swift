//
//  ManageAccountView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI

struct ManageAccountView: View {
    @Binding var nameText: String
    @Binding var occupationText: String
    enum Field: Hashable {
        case nameField
        case occupationField
    }
    @FocusState private var focusedField: Field?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("p1")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Button {
                    
                } label: {
                    Text("Change photo")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 15))
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                NYCTextField(title: "Your name", placeholder: "Your name", text: $nameText)
                    .focused($focusedField, equals: .nameField)
                NYCTextField(title: "Your occupation", placeholder: "Your occupation", text: $occupationText)
                    .focused($focusedField, equals: .occupationField)
            }.padding([.leading,.trailing], 16)
            
            Button(action: {
//                        makeAction()
            }, label: {
                Text("Continue")
            })
            .padding(.bottom, 10)
            .padding([.leading,.trailing], 16)
            .disabled(nameText == "")
            .buttonStyle(NYCActionButtonStyle())
            .padding(.top, 20)
            
        }
        .scrollDisabled(true)
        .onTapGesture {
            focusedField = nil
        }
    }
}

//struct ManageAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageAccountView()
//    }
//}
