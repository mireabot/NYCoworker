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
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(0..<3){_ in
                        FavoriteLocationCell()
                    }
                }
                .padding([.leading,.trailing], 16)
                .padding(.top, 20)
                Spacer()
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
