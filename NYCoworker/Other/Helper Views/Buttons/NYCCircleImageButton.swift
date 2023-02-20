//
//  NYCCircleImageButton.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/1/23.
//

import SwiftUI

struct NYCCircleImageButton: View {
    var size: CGFloat
    var image: Image
        var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            image
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(Resources.Colors.primary)
                .padding(6)
                .background(Resources.Colors.customGrey)
                .cornerRadius(size)
        }

    }
}

