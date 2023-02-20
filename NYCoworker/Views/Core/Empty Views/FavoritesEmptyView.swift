//
//  FavoritesEmptyView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/19/23.
//

import SwiftUI

struct FavoritesEmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("favoritesEmpty")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            VStack(alignment: .center, spacing: 10) {
                Text("Add locations to favorites")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 20))
                Text("Once you add any locations to favorites, you can see it here")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .multilineTextAlignment(.center)
                    .font(Resources.Fonts.regular(withSize: 17))
            }
        }
        .padding([.leading,.trailing], 16)
    }
}

struct FavoritesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesEmptyView()
    }
}
