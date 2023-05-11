//
//  ReviewEmptyView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/9/23.
//

import SwiftUI

struct ReviewEmptyView: View {
    var body: some View {
        VStack {
            Text("No reviews so far")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 17))
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
    }
}

struct ReviewEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewEmptyView()
    }
}
