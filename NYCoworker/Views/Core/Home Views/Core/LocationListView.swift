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
    init(title: String) {
        self.title = title
    }
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 10) {
                    ForEach(locationVM.librariesLocations){ location in
                        NavigationLink(value: location) {
                            LocationListCell(type: .list, data: location) {
                                addToFavs.toggle()
                            }
                        }
                    }
                }
                .padding([.leading,.trailing], 16)
            }
            .navigationDestination(for: LocationModel.self, destination: { locationData in
                LocationDetailView(locationData: locationData)
            })
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
            .navigationBarTitleDisplayMode(.inline)
            .hideTabbar(shouldHideTabbar: true)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct LocationListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationListView()
//    }
//}
