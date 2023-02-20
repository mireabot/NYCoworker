//
//  FavoriteView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.dismiss) var makeDismiss
    var body: some View {
        NavigationStack {
            VStack {
//                ScrollView(.vertical, showsIndicators: true) {
//                    VStack(spacing: 10) {
//                        ForEach(0..<3){_ in
//                            LocationListCell(type: .favorite) {
//                                print("Remove from favs")
//                            }
//                        }
//                    }
//                    .padding([.leading,.trailing], 16)
//                    Spacer()
//                }
                
                FavoritesEmptyView()
            }
            .hideTabbar(shouldHideTabbar: true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        makeDismiss()
                    } label: {
                        Resources.Images.Navigation.arrowBack
                            .foregroundColor(Resources.Colors.primary)
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Your favorites")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 17))
                }
            })
            .navigationBarBackButtonHidden()
            .toolbarBackground(.white, for: .navigationBar)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
