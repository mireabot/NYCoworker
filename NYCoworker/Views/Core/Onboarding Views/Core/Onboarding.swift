//
//  Onboarding.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/25/23.
//

import SwiftUI
import iPages

struct Onboarding: View {
    @State var currentPage: Int = 0
    @State private var showingCredits = false
    let heights = stride(from: 0.4, through: 0.4, by: 0.1).map { PresentationDetent.fraction($0) }
    @State var prepareToNavigate: Bool = false
    let onboardingCoordinator = OnboardingCoordinator()
    var body: some View {
        NavigationStack {
            VStack {
                /// Top header with logo and lamguage button
                HStack {
                    Image("appLogo")
                        .resizable()
                        .frame(width: 70, height: 70)
                    
                    Spacer()
                    
                    Button {
                        showingCredits.toggle()
                    } label: {
                        HStack(spacing: 5) {
                            Image("language")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(Resources.Colors.lightGrey)
                                .frame(width: 20, height: 20)
                            
                            Text("English")
                                .font(Resources.Fonts.regular(withSize: 13))
                                .foregroundColor(Resources.Colors.darkGrey)
                            
                        }
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Resources.Colors.lightGrey)
                        )
                    }
                    
                }
                .padding([.leading,.trailing], 16)
                
                Spacer()
                /// Page control with main content
                iPages(selection: $currentPage) {
                    FirstView()
                    SecondView()
                    ThirdView()
                }
                .dotsTintColors(currentPage: Resources.Colors.primary, otherPages: Resources.Colors.customGrey)
                .hideDots(false)
                .wraps(true)
                .animated(true)
                .padding(.bottom, 40)
                
                Spacer()
                
                /// Bottom footer with button
                VStack(alignment: .leading, spacing: 15) {
                    NYCActionButton(action: {
                        prepareToNavigate.toggle()
                    }, text: "Get Started")
                    
                    Text("By pressing “Get started” button, you agree to our \(Text("Terms of service").foregroundColor(Resources.Colors.actionGreen)) and \(Text("Privacy Policy").foregroundColor(Resources.Colors.actionGreen))")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 13))
                }
                .padding(.bottom, 10)
                .padding([.trailing,.leading], 16)
            }
            .sheet(isPresented: $showingCredits) {
                LanguageSetup()
                    .presentationDetents(Set(heights))
            }
            .navigationDestination(isPresented: $prepareToNavigate) {
                onboardingCoordinator.start()
                                .environmentObject(onboardingCoordinator)
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

struct FirstView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 28, height: 160)
                .cornerRadius(10)
                .padding(.bottom, 30)
            
            VStack(spacing: 5) {
                Text("Welcome to NYCoworker!")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 22))
                
                Text("Extend your working space!")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 17))
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 28, height: 160)
                .cornerRadius(10)
                .padding(.bottom, 30)
            
            VStack(spacing: 5) {
                Text("Find new spots around NYC")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 22))
                
                Text("Choose any location from our hand picked list")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 17))
            }
        }
    }
}

struct ThirdView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 28, height: 160)
                .cornerRadius(10)
                .padding(.bottom, 30)
            
            VStack(spacing: 5) {
                Text("Connect with coworkers")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 22))
                
                Text("Explore coworkers who work in the same space")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 17))
            }
        }
    }
}
