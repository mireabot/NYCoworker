//
//  NYCLoadingSpinner.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/23/23.
//

import SwiftUI

struct NYCLoadingSpinner: View {
    @State var spinnerActive = false
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .trim(from: 1/4, to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Resources.Colors.primary)
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(spinnerActive ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .onAppear {
                        self.spinnerActive = true
                    }
            }
        }
    }
}

struct NYCLoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        NYCLoadingSpinner()
    }
}
