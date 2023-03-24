//
//  Router.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/24/23.
//

import SwiftUI

class Router: ObservableObject {
    
    enum Route {
        case navigation
        case sheet
        case fullScreenCover
        case modal
    }
    
    struct NavigationState {
        var navigationPath: [RoutingViews] = []
        var presentingSheet: RoutingViews? = nil
        var presentingFullScreen: RoutingViews? = nil
        var presentingModal: RoutingViews? = nil
        var isPresented: Binding<RoutingViews?>
        
        var isPresenting: Bool {
            presentingSheet != nil || presentingFullScreen != nil || presentingModal != nil
        }
    }
    
    @Published private(set) var state: NavigationState
    
    init(isPresented: Binding<RoutingViews?>) {
        state = NavigationState(isPresented: isPresented)
    }
    
    func view(spec: RoutingViews, route: Route) -> AnyView {
        AnyView(EmptyView())
    }
}

extension Router {
    
    func navigateTo(_ viewSpec: RoutingViews) {
        state.navigationPath.append(viewSpec)
    }
    
    func navigateBack() {
        state.navigationPath.removeLast()
    }
    
    func replaceNavigationStack(path: [RoutingViews]) {
        state.navigationPath = path
    }
    
    func presentSheet(_ viewSpec: RoutingViews) {
        state.presentingSheet = viewSpec
    }
    
    func presentFullScreen(_ viewSpec: RoutingViews) {
        state.presentingFullScreen = viewSpec
    }
    
    func presentModal(_ viewSpec: RoutingViews) {
        state.presentingModal = viewSpec
    }
    
    func dismiss() {
        if state.presentingSheet != nil {
            state.presentingSheet = nil
        } else if state.presentingFullScreen != nil {
            state.presentingFullScreen = nil
        } else if state.presentingModal != nil {
            state.presentingModal = nil
        } else if navigationPath.count > 1 {
            state.navigationPath.removeLast()
        } else {
            state.isPresented.wrappedValue = nil
        }
    }
}

extension Router {
    
    var navigationPath: Binding<[RoutingViews]> {
        binding(keyPath: \.navigationPath)
    }
    
    var presentingSheet: Binding<RoutingViews?> {
        binding(keyPath: \.presentingSheet)
    }
    
    var presentingFullScreen: Binding<RoutingViews?> {
        binding(keyPath: \.presentingFullScreen)
    }
    
    var presentingModal: Binding<RoutingViews?> {
        binding(keyPath: \.presentingModal)
    }
    
    var isPresented: Binding<RoutingViews?> {
        state.isPresented
    }
}

private extension Router {
    
    func binding<T>(keyPath: WritableKeyPath<NavigationState, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}

