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
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Text("1")
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.close) {
                        makeDismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.location) {
                        
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
