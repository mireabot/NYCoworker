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
    var body: some View {
        VStack {
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
                NYCTextField(title: "Your occupation", placeholder: "Your occupation", text: $occupationText)
            }.padding([.leading,.trailing], 16)
            
            Spacer()
            
            Button(action: {
//                        makeAction()
            }, label: {
                Text("Continue")
            })
            .padding(.bottom, 10)
            .padding([.leading,.trailing], 16)
            .disabled(nameText == "")
            .buttonStyle(NYCActionButtonStyle())
            
        }
    }
}

//struct ManageAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageAccountView()
//    }
//}
