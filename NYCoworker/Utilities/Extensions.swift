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
  
  func disableRefresh() -> some View {
    self.environment(\EnvironmentValues.refresh as! WritableKeyPath<EnvironmentValues, RefreshAction?>, nil)
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
  
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      ZStack(alignment: alignment) {
        placeholder().opacity(shouldShow ? 1 : 0)
        self
      }
    }
}

extension Date {
  func toString(_ format: String)->String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}

//MARK: - Hyperlinking in Text
extension LocalizedStringKey.StringInterpolation {
    /// String interpolation support for links in Text.
    ///
    /// Usage:
    ///
    ///     let url: URL = …
    ///     Text("\("Link title", url: url)")
    mutating func appendInterpolation(_ linkTitle: String, link url: URL) {
      var linkString = AttributedString(linkTitle)
        linkString.link = url
      linkString.foregroundColor = .init(uiColor: UIColor(red: 0.11, green: 0.47, blue: 0.45, alpha: 1.00))
        self.appendInterpolation(linkString)
    }

    /// String interpolation support for links in Text.
    ///
    /// Usage:
    ///
    ///     Text("\("Link title", url: "https://example.com")")
    mutating func appendInterpolation(_ linkTitle: String, link urlString: String) {
        self.appendInterpolation(linkTitle, link: URL(string: urlString)!)
    }
}
