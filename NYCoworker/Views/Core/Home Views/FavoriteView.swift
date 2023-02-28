//
//  FavoriteView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI
import PopupView

struct FavoriteView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var showLoading = false
    var body: some View {
        NavigationStack {
            favoritesView()
                .toolbar(.hidden, for: .tabBar)
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
                .popup(isPresented: $showLoading) {
                    LoadingBottomView()
                } customize: {
                    $0
                        .closeOnTap(false)
                        .closeOnTapOutside(true)
                        .backgroundColor(.black.opacity(0.4))
                }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.white, for: .navigationBar)
        }
    }
    
    @ViewBuilder
    func emptyState() -> some View {
        VStack {
            FavoritesEmptyView()
        }
    }
    
    @ViewBuilder
    func favoritesView() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 10) {
                ForEach(0..<3){_ in
                    NavigationLink(destination: LocationDetailView()) {
                        LocationListCell(type: .favorite) {
                            showLoading.toggle()
                        }
                    }
                }
            }
            .padding([.leading,.trailing], 16)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
