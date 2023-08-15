//
//  OnboardingNavigationCoordinator.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/4/23.
//

import SwiftUI

class OnboardingCoordinator: ObservableObject {
    var onboardingView: AccountSetupView?
    
    func start() -> AccountSetupView {
        let onboardingView = AccountSetupView()
        self.onboardingView = onboardingView
        return onboardingView
    }
    
    func nextStep() {
        onboardingView?.currentStep += 1
    }
    
    func previousStep() {
        onboardingView?.currentStep -= 1
    }
}
