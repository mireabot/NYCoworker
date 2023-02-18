//
//  LogoutView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI

struct LogoutView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 15) {
                Text("Are you sure you want to log out?")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 17))
                
                VStack(alignment: .center, spacing: 10) {
                    NYCActionButton(action: {
                        
                    }, text: "Log out", buttonStyle: .system)
                    
                    Button {
                        
                    } label: {
                        Text("Never mind")
                            .foregroundColor(Resources.Colors.darkGrey)
                            .font(Resources.Fonts.bold(withSize: 17))
                    }

                }
                
            }
            .frame(maxWidth: .infinity)
            .padding([.leading,.trailing], 16)
            Spacer()
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
