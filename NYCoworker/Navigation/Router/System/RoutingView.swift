//
//  RoutingView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/23/23.
//

import SwiftUI

struct RoutingView<Content: View>: View {
    
    @StateObject var router: Router
    @State var selectDetent : PresentationDetent = .bottom
    private let content: Content
    
    init(router: Router, @ViewBuilder content: @escaping () -> Content) {
        _router = StateObject(wrappedValue: router)
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: router.navigationPath) {
            content
                .navigationDestination(for: ViewSpec.self) { spec in
                    router.view(spec: spec, route: .navigation)
                }
        }.sheet(item: router.presentingSheet) { spec in
            router.view(spec: spec, route: .sheet)
                .presentationDetents(
                    [.mediumBottomBar, .largeBottomBar],
                    selection: $selectDetent
                )
        }.fullScreenCover(item: router.presentingFullScreen) { spec in
            router.view(spec: spec, route: .fullScreenCover)
        }
        .sheet(item: router.presentingSheet) { spec in
            router.view(spec: spec, route: .smallSheet)
                .presentationDetents(
                    [.mediumBottomBar],
                    selection: $selectDetent
                )
        }
    }
}

