//
//  LoadingBottomView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/23/23.
//

import SwiftUI

struct LoadingBottomView: View {
    var title: String?
    var body: some View {
        VStack {
            NYCLoadingSpinner(isAnimating: .constant(true), style: .large)
            
            Text(title ?? "Hand tight")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 20))
                .padding(.top, 20)
        }
        .padding(30)
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct LoadingBottomView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBottomView()
    }
}
