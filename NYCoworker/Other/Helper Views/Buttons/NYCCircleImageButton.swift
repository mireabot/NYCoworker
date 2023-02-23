//
//  NYCCircleImageButton.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/1/23.
//

import SwiftUI

struct NYCCircleImageButton: View {
    enum ColorType {
        case black
        case green
    }
    var size: CGFloat
    var image: Image
    var color: ColorType? = .green
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            image
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(color == .green ? Resources.Colors.primary : Resources.Colors.customBlack)
                .padding(6)
                .background(Resources.Colors.customGrey)
                .cornerRadius(size)
        }

    }
}

