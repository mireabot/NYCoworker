//
//  RootNavigationController.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/13/23.
//

import SwiftUI

/// Reusable Navigation Controller to be used as the root controller
struct RootNavigationController<RootView: View>: UIViewControllerRepresentable {
  
  let nav: UINavigationController
  let rootView: RootView
  let navigationBarHidden: Bool
  
  init(nav: UINavigationController, rootView: RootView, navigationBarHidden: Bool = true) {
    self.nav = nav
    self.rootView = rootView
    self.navigationBarHidden = navigationBarHidden
  }
  
  func makeUIViewController(context: Context) -> UINavigationController {
    let vc = CustomHostingController(rootView: rootView, navigationBarHidden: navigationBarHidden)
    nav.navigationBar.isHidden = true
    nav.navigationBar.isTranslucent = false
    nav.addChild(vc)
    return nav
  }
  
  func updateUIViewController(_ pageViewController: UINavigationController, context: Context) {
  }
  
}
