//
//  LocationsMapView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import MapKit

struct LocationsMapView: View {
    @Environment(\.dismiss) var makeDismiss
    @ObservedObject var locationVM: LocationsViewModel
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $locationVM.mapRegion, annotationItems: locationVM.locations, annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        Image("mapPin")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Resources.Colors.primary)
                            .scaleEffect(locationVM.mapLocation == location ? 1 : 0.7)
                            .onTapGesture {
                                locationVM.showNextLocation(location: location)
                            }
                    }
                }).edgesIgnoringSafeArea(.all)
                
                ZStack {
                    ForEach(locationVM.locations) { location in
                        if locationVM.mapLocation == location {
                            LocationMapCard(location: location)
                                .transition(.asymmetric(insertion: .move(edge: .trailing),removal: .move(edge: .leading)))
                                .onTapGesture {
                                    print("Open location screen")
                                }
                        }
                    }
                }
                .padding(.bottom, 30)
                .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                    .onEnded { value in
                        print(value.translation)
                        switch(value.translation.width, value.translation.height) {
                        case (...0, -30...30):  locationVM.pushNextLocation()
                            default:  print("no clue")
                        }
                    }
                )
                
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden()
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.arrowBack, color: .black) {
                        makeDismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.location, color: .black) {
                        
                    }
                }
            }
        }
    }
}

//struct LocationsMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationsMapView()
//    }
//}
