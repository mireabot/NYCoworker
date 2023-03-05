//
//  NYCNavigationButton.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/2/23.
//

import SwiftUI

enum NYCNavigationButtonType: String {
    case next = "Next"
    case back = "Back"
}

struct NYCNavigationButton: View {
    var type: NYCNavigationButtonType
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Text(type.rawValue)
            }
            .font(Resources.Fonts.regular(withSize: 17))
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .foregroundColor(type == .back ? Resources.Colors.primary : Color.white)
            .background(type == .back ? Resources.Colors.customGrey : Resources.Colors.primary)
        }
        .buttonStyle(.plain)
        .cornerRadius(10)

    }
}

struct NYCNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            NYCNavigationButton(type: .back, action: {})
            NYCNavigationButton(type: .next, action: {})
        }
    }
}
