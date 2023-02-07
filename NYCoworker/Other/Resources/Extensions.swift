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
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners))
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
