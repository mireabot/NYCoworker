//
//  NYCNavigationButton.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/2/23.
//

import SwiftUI

enum NYCNavigationButtonType {
  case next
  case back
  case start
  
  var title: String {
    switch self {
    case .next:
      return "Next"
    case .back:
      return "Back"
    case .start:
      return "Get started"
    }
  }
  
  var activeColor: Color {
    switch self {
    case .next:
      return Resources.Colors.primary
    case .back:
      return Resources.Colors.customGrey
    case .start:
      return Resources.Colors.primary
    }
  }
  
  var textColor: Color {
    switch self {
    case .next:
      return .white
    case .back:
      return Resources.Colors.primary
    case .start:
      return .white
    }
  }
  
  var disabledColor: Color {
    switch self {
    case .next:
      return Resources.Colors.customGrey
    case .back:
      return Resources.Colors.customGrey
    case .start:
      return Resources.Colors.customGrey
    }
  }
  
  var disabledTextColor: Color {
    switch self {
    case .next:
      return Resources.Colors.darkGrey
    case .back:
      return Resources.Colors.darkGrey
    case .start:
      return Resources.Colors.darkGrey
    }
  }
}

struct NYCNavigationButton: View {
  var type: NYCNavigationButtonType
  var action: () -> Void
  var body: some View {
    Button {
      action()
    } label: {
      Text(type.title)
        .font(Resources.Fonts.medium(withSize: 17))
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .foregroundColor(type.textColor)
        .background(type.activeColor)
    }
    .cornerRadius(10)
    
  }
}

struct NYCNavigationButton_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      NYCNavigationButton(type: .back, action: {})
      NYCNavigationButton(type: .next, action: {})
      Button {
        
      } label: {
        Text("Next")
      }
      .buttonStyle(NYCNavigationButtonStyle())

    }
  }
}

struct NYCNavigationButtonStyle: ButtonStyle {
  func makeBody(configuration: ButtonStyle.Configuration) -> some View {
    MyButton(configuration: configuration)
  }
  
  struct MyButton: View {
    let configuration: ButtonStyle.Configuration
    @Environment(\.isEnabled) private var isEnabled: Bool
    var body: some View {
      configuration.label
        .font(Resources.Fonts.medium(withSize: 17))
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .foregroundColor(isEnabled ? .white : Resources.Colors.darkGrey)
        .background(isEnabled ? Resources.Colors.primary : Resources.Colors.customGrey)
        .cornerRadius(10)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
  }
}
