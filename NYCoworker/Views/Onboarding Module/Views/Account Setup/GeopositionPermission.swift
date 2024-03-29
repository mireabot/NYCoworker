//
//  GeopositionPermission.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI
import PopupView

struct GeopositionPermission: View {
  @EnvironmentObject var model: UserRegistrationModel
  @StateObject var locationManager = LocationManager()
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
            .font(Resources.Fonts.medium(withSize: 34))
        }
        
        Spacer()
      }
      .padding([.leading,.trailing], 16)
      .padding(.top, 30)
      
      Spacer()
    }
    .onAppear {
      locationManager.locationManager.delegate = locationManager
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        model.geolocationPermissionGranted = true
      }
    }
    .popup(isPresented: $locationManager.permissionDenied) {
      NYCMiddleAlertView(alertType: .geolocationRejected, action: {
        model.geolocationPermissionGranted = true
        locationManager.permissionDenied.toggle()
      })
    } customize: {
      $0
        .closeOnTap(false)
        .closeOnTapOutside(true)
        .backgroundColor(.black.opacity(0.4))
    }
  }
}

struct GeopositionPermission_Previews: PreviewProvider {
  static var previews: some View {
    GeopositionPermission()
  }
}
