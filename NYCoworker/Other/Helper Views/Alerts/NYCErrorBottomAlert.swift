//
//  NYCErrorBottomAlert.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/18/23.
//

import SwiftUI

struct NYCBottomErrorAlert: View {
    @Binding var show: Bool
    var errorTitle: String
    var action: () -> Void
    var body: some View {
        if show {
            ZStack(alignment: .bottom) {
                Color.black.opacity(0.25).edgesIgnoringSafeArea(.all)
                
                HStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(errorTitle)
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.bold(withSize: 24))
                            Text("Try again please")
                                .foregroundColor(Resources.Colors.darkGrey)
                                .font(Resources.Fonts.regular(withSize: 17))
                        }
                        
                        Button {
                            action()
                        } label: {
                            Text("Try again")
                        }
                        
                        .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
                        
                    }
                    .padding([.leading,.trailing], 16)
                    .frame(maxWidth: .infinity,alignment: .center)
                    Spacer()
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .transition(.move(edge: .bottom))
                .animation(.spring(), value: show)
            }
        }
    }
}

