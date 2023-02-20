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
    enum ButtonView {
        case primary
        case secondary
        case system
    }
    var buttonStyle: ButtonView?
    var body: some View {
        VStack {
            switch buttonStyle {
            case .primary:
                primaryButton
            case .secondary:
                secondaryButton
            case .system:
                systemButton
            case .none:
                primaryButton
            }
        }
    }
    var primaryButton: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Color.white)
                .padding([.top,.bottom], 13)
                .font(Resources.Fonts.regular(withSize: 17))
                .frame(maxWidth: .infinity)
        }
        .background(Resources.Colors.primary)
        .cornerRadius(10)
    }
    var systemButton: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Color.white)
                .padding([.top,.bottom], 13)
                .font(Resources.Fonts.regular(withSize: 17))
                .frame(maxWidth: .infinity)
        }
        .background(Resources.Colors.actionRed)
        .cornerRadius(10)
    }
    var secondaryButton: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Resources.Colors.primary)
                .padding([.top,.bottom], 13)
                .font(Resources.Fonts.regular(withSize: 17))
                .frame(maxWidth: .infinity)
        }
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
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
