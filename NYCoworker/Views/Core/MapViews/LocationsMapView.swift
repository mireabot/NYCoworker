//
//  LocationsMapView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI

struct LocationsMapView: View {
    @Environment(\.dismiss) var makeDismiss
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.blue.edgesIgnoringSafeArea(.all)
                
                LocationMapCard()
                    .padding(.bottom, 30)
                
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

struct LocationsMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsMapView()
    }
}
