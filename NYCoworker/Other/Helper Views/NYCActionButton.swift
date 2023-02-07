//
//  NYCActionButton.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI

struct NYCActionButton: View {
    var action: () -> Void
    var text: String
    var system: Bool?
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(text)
                    .foregroundColor(Color.white)
                    .padding([.top,.bottom], 13)
                    .font(Resources.Fonts.regular(withSize: 17))
                    .frame(maxWidth: .infinity)
            }
            .background(system ?? false ? Resources.Colors.actionRed : Resources.Colors.primary)
            .cornerRadius(10)

        }
    }
}

struct NYCActionButtonStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }

    struct MyButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .foregroundColor(isEnabled ? Color.white : Resources.Colors.darkGrey)
                .padding([.top,.bottom], 15)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 5).fill(isEnabled ? Resources.Colors.primary : Resources.Colors.customGrey))
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
}
