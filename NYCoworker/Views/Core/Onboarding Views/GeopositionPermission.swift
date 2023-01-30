//
//  GeopositionPermission.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI

struct GeopositionPermission: View {
    @ObservedObject var locationManager = LocationModel.shared
    var body: some View {
        VStack {
            /// Content stack
            HStack {
                VStack(alignment: .leading) {
                    Image("geoposition")
                        .resizable()
                        .frame(width: 70, height: 70)
                    
                    Text("Discover local coworkers and spots near you, wherever you are")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 34))
                }
                
                Spacer()
            }
            .padding([.leading,.trailing], 16)
            .padding(.top, 30)
            
            Spacer()
            
            NYCActionButton(action: {
                LocationModel.shared.requestLocation {
                    checkForLocationAccess()
                }
            }, text: "Continue")
            .padding(.bottom, 10)
        }
        .toolbar(.hidden)
    }
    
    func checkForLocationAccess() {
        if locationManager.status! {
            print("Ok")
        }
        else { print("Not ok")}
    }
}

struct GeopositionPermission_Previews: PreviewProvider {
    static var previews: some View {
        GeopositionPermission()
    }
}
