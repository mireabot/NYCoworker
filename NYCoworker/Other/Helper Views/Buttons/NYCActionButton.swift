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
        case secondarySystem
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
            case .secondarySystem:
                secondarySystemButton
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
    
    var secondarySystemButton: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Resources.Colors.darkGrey)
                .padding([.top,.bottom], 13)
                .font(Resources.Fonts.regular(withSize: 17))
                .frame(maxWidth: .infinity)
        }
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
    }
}

struct NYCActionButtonStyle: ButtonStyle {
    @Binding var showLoader: Bool
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, showLoader: $showLoader)
    }
    
    struct MyButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Binding var showLoader: Bool
        var body: some View {
            HStack {
                if showLoader {
                    CircularProgress()
                }
                else {
                    configuration.label
                    
                }
            }
            .foregroundColor(isEnabled ? Color.white : Resources.Colors.darkGrey)
            .padding([.top,.bottom], 15)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 5).fill(isEnabled ? Resources.Colors.primary : Resources.Colors.customGrey))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
}

public struct CircularProgress: View {
    @State private var isCircleRotation = true
    @State private var animationStart = false
    @State private var animationEnd = false
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .fill(Color.white)
                .frame(width: 20, height: 20)
            
            Circle()
                .trim(from: animationStart ? 1/3 : 1/9, to: animationEnd ? 2/5 : 1)
                .stroke(lineWidth: 4)
                .rotationEffect(.degrees(isCircleRotation ? 360 : 0))
                .frame(width: 20, height: 20)
                .foregroundColor(Resources.Colors.lightGrey)
                .onAppear {
                    withAnimation(Animation
                        .linear(duration: 1)
                        .repeatForever(autoreverses: false)) {
                            self.isCircleRotation.toggle()
                        }
                    withAnimation(Animation
                        .linear(duration: 1)
                        .delay(0.5)
                        .repeatForever(autoreverses: true)) {
                            self.animationStart.toggle()
                        }
                    withAnimation(Animation
                        .linear(duration: 1)
                        .delay(1)
                        .repeatForever(autoreverses: true)) {
                            self.animationEnd.toggle()
                        }
                }
        }
    }
}
