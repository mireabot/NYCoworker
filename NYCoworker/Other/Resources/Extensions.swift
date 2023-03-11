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
    
    func addTransition() -> some View {
        self.transition(.move(edge: .trailing))
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

//MARK: - Bottom sheets
extension View {
    
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
    
    func shadowedStyle() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }
    
    func paddingForHeader() -> some View {
        self.padding(.top, 20)
    }
}

extension Date {
    func toString(_ format: String)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

//MARK: - Bottom sheet presentation
extension PresentationDetent {
    static let bottom = Self.custom(BottomBarDetent.self)
    static let mediumBottomBar = Self.medium
    static let largeBottomBar = Self.large
}

private struct BottomBarDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        max(200, context.maxDetentValue * 0.1)
    }
    
    static func height(in context: Context, withHeight height: CGFloat? = nil) -> CGFloat? {
        max(height ?? 200, context.maxDetentValue * 0.1)
    }
}
