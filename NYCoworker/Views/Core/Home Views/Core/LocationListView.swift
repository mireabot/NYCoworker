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
    @EnvironmentObject var locationService: LocationService
    @State var addToFavs = false
    private var title: String
    var locationType: LocationType
    @AppStorage("UserID") var userId : String = ""
    init(title: String, type: LocationType) {
        self.title = title
        self.locationType = type
    }
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 10) {
                    switch locationType {
                    case .library:
                        libraryLocations()
                    case .hotel:
                        hotelsLocations()
                    case .publicSpace:
                        publicSpacesLocations()
                    }
                }
                .padding([.leading,.trailing], 16)
            }
            .navigationDestination(for: Location.self, destination: { locationData in
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
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    func hotelsLocations() -> some View {
        ForEach(locationService.locations){ location in
            if location.locationType == .hotel {
                NavigationLink(value: location) {
                    LocationListCell(type: .list, data: location) {
                        Task {
                            do {
                                await locationService.addFavoriteLocation(locationID: location.locationID, userID: userId, completion: {
                                    addToFavs.toggle()
                                }) { err in
                                    print(err.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func libraryLocations() -> some View {
        ForEach(locationService.locations){ location in
            if location.locationType == .library {
                NavigationLink(value: location) {
                    LocationListCell(type: .list, data: location) {
                        Task {
                            do {
                                await locationService.addFavoriteLocation(locationID: location.locationID, userID: userId, completion: {
                                    addToFavs.toggle()
                                }) { err in
                                    print(err.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func publicSpacesLocations() -> some View {
        ForEach(locationService.locations){ location in
            if location.locationType == .publicSpace {
                NavigationLink(value: location) {
                    LocationListCell(type: .list, data: location) {
                        Task {
                            do {
                                await locationService.addFavoriteLocation(locationID: location.locationID, userID: userId, completion: {
                                    addToFavs.toggle()
                                }) { err in
                                    print(err.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct LocationListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationListView()
//    }
//}
