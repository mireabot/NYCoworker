//
//  ProfileSetup.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI

struct ProfileSetup: View {
    @EnvironmentObject var model: UserRegistrationModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            /// Header
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Complete your profile")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 22))
                    Text("This information will help us improve your app experience")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 17))
                }
                
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 10)
            
            /// Main section - Name, Occupation, Personality
            VStack(alignment: .leading) {
                NYCTextField(title: "Your name", placeholder: "Ex. Michael", text: $model.name)
                NYCTextField(title: "Describe occupation", placeholder: "Ex. Freelancer", text: $model.occupation)
            }
            .padding([.leading,.trailing], 16)
            .padding(.top, 30)
            
        }
        .addTransition()
        .scrollDisabled(true)
    }
}

struct ProfileSetup_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetup()
    }
}
