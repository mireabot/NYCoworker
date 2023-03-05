//
//  OnboardingNavigationCoordinator.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/4/23.
//

import SwiftUI

class OnboardingCoordinator: ObservableObject {
    var onboardingView: AccoutSetupView?
    
    func start() -> AccoutSetupView {
        let onboardingView = AccoutSetupView()
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
