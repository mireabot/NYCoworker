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
    @StateObject var locationVM : LocationsViewModel = .shared
    var body: some View {
        NavigationStack {
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
    func favoritesListView() -> some View {
        List {
            ForEach(locationVM.locations){ location in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: LocationDetailView()) {
                        EmptyView()
                    }.opacity(0)
                    
                    LocationListCell(type: .favorite, data: location, buttonAction: {})
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
