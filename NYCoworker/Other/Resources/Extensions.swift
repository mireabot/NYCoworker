//
//  Extensions.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI

//MARK: - String
extension String {
    
    var withSingleTrailingSpace:  String {
        appending(" ")
    }
    
    var withSingleLeadingSpace:  String {
        " " + self
    }
}

extension View {
    
    func hideTabbar(shouldHideTabbar: Bool) -> some View {
        self.modifier(HideTabbarModifier(shouldHideTabbar: shouldHideTabbar))
    }
}
