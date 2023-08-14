//
//  NavigationViewBuilder.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/13/23.
//

import UIKit
import SwiftUI

final class NYCNavigationViewBuilder: NavigationViewBuilder {
    
    static let builder = NYCNavigationViewBuilder()
    
    private init() {}
    
    func makeView<T: View>(_ view: T) -> UIViewController {
        CustomHostingController(rootView: view, navigationBarHidden: true)
    }
}

final class NYCNavigationViewsRouter: Router {
    var nav: UINavigationController?
    
    func pushTo(view: UIViewController) {
        nav?.pushViewController(view, animated: true)
    }
    
    func popTo(view: UIViewController) {
        nav?.popToViewController(view, animated: true)
    }
}
