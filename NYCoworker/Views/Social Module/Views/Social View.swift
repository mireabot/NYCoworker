//
//  Social View.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI

struct SocialView: View {
    var body: some View {
        VStack {
            /// Social card
            ShareCardView {
                
            }
            
            /// Title label
            HStack {
                Text("How it works?")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.medium(withSize: 17))
                
                Spacer()
            }
            .padding(.leading, 16)
            
            VStack(spacing: 10) {
                NYCSocialCard(data: socialData[0])
                   
                NYCSocialCard(data: socialData[1])
                    
                NYCSocialCard(data: socialData[2])
                    
            } .padding([.leading,.trailing], 16)
            
            
            
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NYCHeader(title: "Find coworkers")
            }
        }
    }
}

struct Social_View_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
