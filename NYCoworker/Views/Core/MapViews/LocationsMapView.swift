//
//  LocationsMapView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import MapKit
import PopupView

struct LocationsMapView: View {
    @Environment(\.dismiss) var makeDismiss
    @StateObject var locationVM: LocationsViewModel = .shared
    @State var showAlert = false
    @StateObject var locationManager = LocationManager()
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $locationVM.mapRegion, showsUserLocation: true, annotationItems: locationVM.locations, annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        Image("mapPin")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .scaleEffect(locationVM.mapLocation == location ? 1 : 0.7)
                            .onTapGesture {
                                locationVM.showNextLocation(location: location)
                            }
                    }
                }).edgesIgnoringSafeArea(.all)
                
                ZStack {
                    ForEach(locationVM.locations) { location in
                        if locationVM.mapLocation == location {
                            NavigationLink(destination: LocationDetailView(locationData: location)) {
                                LocationMapCard(location: location, buttonAction: {
                                    showAlert.toggle()
                                }).transition(.asymmetric(insertion: .move(edge: .trailing),removal: .move(edge: .leading)))
                            }
                        }
                    }
                }
                .padding(.bottom, 30)
                
            }
            .navigationDestination(for: LocationModel.self, destination: { locationData in
                LocationDetailView(locationData: locationData)
            })
            .popup(isPresented: $showAlert) {
                NYCAlertNotificationView(alertStyle: .addedToFavorites)
            } customize: {
                $0
                    .isOpaque(true)
                    .autohideIn(1.5)
                    .type(.floater())
                    .position(.top)
                    .animation(.spring(response: 0.4, blendDuration: 0.2))
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbarBackground(.clear, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.arrowBack, color: .black) {
                        makeDismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct LocationsMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationsMapView()
//    }
//}
