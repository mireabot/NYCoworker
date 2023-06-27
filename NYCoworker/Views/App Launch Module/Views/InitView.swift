//
//  InitView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/18/23.
//

import SwiftUI
import Firebase

struct InitView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("userSigned") var userLogged: Bool = false
    @AppStorage("UserID") var userId : String = ""
    @State var appConfig: AppConfig?
    @State var isMaintenanceMode = false
    var body: some View {
        Group {
            if userLogged && !userId.isEmpty  {
                TabBarView()
                    .fullScreenCover(isPresented: $isMaintenanceMode) {
                        MaintenanceOverlayView()
                    }
            }
            else {
                Onboarding()
            }
        }
        .onAppear {
          if Resources.adminMode {
            print("Admin Mode")
          }
          else {
            fetchAppConfig()
          }
        }
    }
}

extension InitView { //MARK: - Functions
  func fetchAppConfig() {
      let db = Firestore.firestore()
      db.collection("AppConfig").document("iF6wRzrbgSP8YI9hbCLl").addSnapshotListener { snapshot, error in
          if let error = error {
              print("Error getting appConfig: \(error)")
          } else if let data = snapshot?.data() {
              // Decode AppConfig struct from database
              do {
                  let appConfig = try Firestore.Decoder().decode(AppConfig.self, from: data)
                  self.appConfig = appConfig
                  self.isMaintenanceMode = appConfig.maintainceMode
              } catch {
                  print("Error decoding appConfig: \(error)")
              }
          }
      }
  }
}
