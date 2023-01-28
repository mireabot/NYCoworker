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
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(text)
                    .foregroundColor(.white)
                    .font(Resources.Fonts.regular(withSize: 17))
                    .frame(width: UIScreen.main.bounds.width - 16, height: 48)
            }
            .background(Resources.Colors.primary)
            .cornerRadius(10)

        }
    }
}
