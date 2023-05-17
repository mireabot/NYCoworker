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
                    
                }
                .padding([.leading,.trailing], 16)
                
                Spacer()
                /// Page control with main content
                iPages(selection: $currentPage) {
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

struct SecondView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("onb1")
                .frame(width: UIScreen.main.bounds.width - 28, height: 250)
                .cornerRadius(10)
                .padding(.bottom, 30)
            
            VStack(spacing: 5) {
                Text("Find the best free places to work")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.medium(withSize: 22))
                    .multilineTextAlignment(.center)
                
                Text("Our app features a hand-picked selection of the coolest productive workspaces in NYC")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 17))
                    .multilineTextAlignment(.center)
            }
            .padding([.leading,.trailing], 16)
        }
    }
}

struct ThirdView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("onb2")
                .frame(width: UIScreen.main.bounds.width - 28, height: 250)
                .cornerRadius(10)
                .padding(.bottom, 30)
            
            VStack(spacing: 5) {
                Text("Expand your professional network")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.medium(withSize: 22))
                    .multilineTextAlignment(.center)
                
                Text("Our app lets you easily explore and connect with coworkers who work in the same location")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 17))
                    .multilineTextAlignment(.center)
            }
            .padding([.leading,.trailing], 16)
        }
        
    }
}
