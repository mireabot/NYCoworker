//
//  HelpSupportView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI

struct HelpSupportView: View {
    var body: some View {
        VStack {
            VStack {
                Image("appLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("NYCoworker")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 22))
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            VStack(spacing: 10) {
                NYCSettingsCard(icon: Resources.Images.Settings.manageAccount, title: "Write feedback")
                NYCSettingsCard(icon: Resources.Images.Settings.website, title: "Visit website")
                NYCSettingsCard(icon: Resources.Images.Settings.rate, title: "Rate app")
            }
            .padding([.leading,.trailing], 16)
            
            NYCSettingsCard(icon: Resources.Images.Settings.faq, title: "FAQ")
                .padding(.top, 50)
                .padding([.leading,.trailing], 16)
            
            Spacer()
        }
    }
}

struct HelpSupportView_Previews: PreviewProvider {
    static var previews: some View {
        HelpSupportView()
    }
}
