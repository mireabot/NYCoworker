//
//  NYCRouter.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/24/23.
//

import SwiftUI

class NYCRouter: Router {
    
    func presentList() {
        presentSheet(.list)
    }
    
    func presentDetail(description: String) {
        navigateTo(.detail)
    }
    
    func presentAlert() {
        presentModal(.alert)
    }
    
    override func view(spec: RoutingViews, route: Route) -> AnyView {
        AnyView(buildView(spec: spec, route: route))
    }
}

private extension NYCRouter {
    
    @ViewBuilder
    func buildView(spec: RoutingViews, route: Route) -> some View {
        switch spec {
        case .list:
            EmptyView()
        case .detail:
            EmptyView()
        case .alert:
           EmptyView()
        case .mapView:
            LocationsMapView(router: router(route: route))
        case .locationDetail(let model):
            LocationDetailView(locationData: model)
        case .locationList(let title):
           LocationListView(title: title, router: router(route: route))
        case .settingsView(let settingsTitle):
            SettingsView(title: settingsTitle)
        case .notificationsView:
            NotificationsView()
        case .favoritesView:
            FavoriteView(router: router(route: route))
        default:
            EmptyView()
        }
    }
            
    func router(route: Route) -> NYCRouter {
        switch route {
        case .navigation:
            return self
        case .sheet:
            return NYCRouter(isPresented: presentingSheet)
        case .fullScreenCover:
            return NYCRouter(isPresented: presentingFullScreen)
        case .modal:
            return self
        }
    }
}
