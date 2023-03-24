//
//  LocationListView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import PopupView

struct LocationListView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var addToFavs = false
    @StateObject var locationVM : LocationsViewModel = .shared
    private var title: String
    @StateObject private var router: NYCRouter
    init(title: String, router: NYCRouter) {
        self.title = title
        _router = StateObject(wrappedValue: router)
    }
    var body: some View {
        RoutingView(router: router) {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 10) {
                    ForEach(locationVM.librariesLocations){ location in
                        LocationListCell(type: .list, data: location) {
                            addToFavs.toggle()
                        }
                        .onTapGesture {
                            router.navigateTo(.locationDetail(location))
                        }

                    }
                }
                .padding([.leading,.trailing], 16)
            }
            .popup(isPresented: $addToFavs) {
                NYCAlertNotificationView(alertStyle: .addedToFavorites)
            } customize: {
                $0
                    .isOpaque(true)
                    .autohideIn(1.5)
                    .type(.floater())
                    .position(.top)
                    .animation(.spring(response: 0.4, blendDuration: 0.2))
            }
            .toolbarBackground(.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        makeDismiss()
                    } label: {
                        Resources.Images.Navigation.arrowBack
                            .foregroundColor(Resources.Colors.primary)
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(title)
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 17))
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .hideTabbar(shouldHideTabbar: true)
        }
    }
}

//struct LocationListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationListView()
//    }
//}
