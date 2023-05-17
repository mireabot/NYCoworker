//
//  PersonTypeSetup.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/2/23.
//

import SwiftUI

struct PersonTypeSetup: View {
    @EnvironmentObject var model: UserRegistrationModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            /// Header
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Which of these describes you best?")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.medium(withSize: 22))
                    Text("You can edit later in profile settings")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 17))
                }
                
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 10)
            
            VStack(alignment: .center, spacing: 15) {
                NYCSetupCard(title: "Student", cardType: model.accountType == "Student" ? .selected : .unselected)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            model.accountType = "Student"
                        }
                    }
                NYCSetupCard(title: "Employed", cardType: model.accountType == "Employed" ? .selected : .unselected)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            model.accountType = "Employed"
                        }
                    }
                NYCSetupCard(title: "Freelancer", cardType: model.accountType == "Freelancer" ? .selected : .unselected)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            model.accountType = "Freelancer"
                        }
                    }
                NYCSetupCard(title: "Prefer not to say", cardType: model.accountType == "Prefer not to say" ? .selected : .unselected)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            model.accountType = "Prefer not to say"
                        }
                    }
            }
            .padding([.leading,.trailing], 16)
            .padding(.top, 20)
        }
        .addTransition()
        .scrollDisabled(true)
        .onAppear {
            model.accountType = "Prefer not to say"
        }
    }
}

struct PersonTypeSetup_Previews: PreviewProvider {
    static var previews: some View {
        GenderTypeSetup()
    }
}

struct GenderTypeSetup: View {
    @EnvironmentObject var model: UserRegistrationModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            /// Header
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("How can we refer to you?")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.medium(withSize: 22))
                    Text("We're committed to creating a welcoming vibe for members of all genders.")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 17))
                }
                
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 10)
            
            VStack(alignment: .center, spacing: 15) {
                NYCSetupCard(title: "She/Her", cardType: model.gender == "She/Her" ? .selected : .unselected).onTapGesture {
                    withAnimation(.spring()) {
                        model.gender = "She/Her"
                    }
                }
                NYCSetupCard(title: "He/Him", cardType: model.gender == "He/Him" ? .selected : .unselected).onTapGesture {
                    withAnimation(.spring()) {
                        model.gender = "He/Him"
                    }
                }
                NYCSetupCard(title: "They/Them", cardType: model.gender == "They/Them" ? .selected : .unselected).onTapGesture {
                    withAnimation(.spring()) {
                        model.gender = "They/Them"
                    }
                }
                NYCSetupCard(title: "Prefer not to say", cardType: model.gender == "Prefer not to say" ? .selected : .unselected).onTapGesture {
                    withAnimation(.spring()) {
                        model.gender = "Prefer not to say"
                    }
                }
            }
            .padding([.leading,.trailing], 16)
            .padding(.top, 20)
        }
        .addTransition()
        .scrollDisabled(true)
        .onAppear {
            model.gender = "Prefer not to say"
        }
    }
}
