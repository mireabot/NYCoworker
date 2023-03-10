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
    init() {
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
    }
    var body: some View {
        NavigationStack {
            //            favoritesView()
            favoritesListView()
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
    
    @ViewBuilder
    func favoritesListView() -> some View {
        List {
            ForEach(0..<3){_ in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: LocationDetailView()) {
                        EmptyView()
                    }.opacity(0)
                    
                    LocationListCell(type: .favorite, buttonAction: {})
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                
                            } label: {
                                Text("Delete")
                                    .font(Resources.Fonts.regular(withSize: 15))
                            }
                            .tint(Resources.Colors.secondary)

                        }
                }
            }.listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
