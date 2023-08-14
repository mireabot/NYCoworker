//
//  HostingController.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/13/23.
//

import SwiftUI

/// Wrapper of SwiftUI view to UIHostingController
class CustomHostingController<Content>: UIHostingController<AnyView> where Content: View {

    public init(rootView: Content, navigationBarHidden: Bool) {
        super.init(rootView: AnyView(rootView.navigationBarHidden(navigationBarHidden)))
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

