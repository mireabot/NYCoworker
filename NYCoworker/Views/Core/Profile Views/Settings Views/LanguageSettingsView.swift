//
//  LanguageSettingsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/27/23.
//

import SwiftUI

struct LanguageSettingsView: View {
    var body: some View {
        VStack {
            VStack(spacing: 25) {
                NYCLanguageCard(title: "English", icon: Resources.Images.Flags.english)
                NYCLanguageCard(title: "Русский", icon: Resources.Images.Flags.russian)
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Update")
            }
            .disabled(true)
            .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
            .padding([.leading,.trailing], 16)
            .padding(.bottom, 20)
        }
    }
}

struct LanguageSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSettingsView()
    }
}
