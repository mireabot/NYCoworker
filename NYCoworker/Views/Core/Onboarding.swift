//
//  Onboarding.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/25/23.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        VStack {
            /// Top header with logo and lamguage button
            HStack {
                Image("appLogo")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(spacing: 10) {
                        Image("language")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color(uiColor: Resources.Colors.lightGrey))
                            .frame(width: 24, height: 24)
                        
                        Text("English")
                            .font(Resources.Fonts.regular(withSize: 13))
                            .foregroundColor(Color(uiColor: Resources.Colors.darkGrey))
                        
                    }
                    .padding(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(uiColor: Resources.Colors.lightGrey))
                        )
                }

            }
            .padding([.leading,.trailing], 16)
            
            Spacer()
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
