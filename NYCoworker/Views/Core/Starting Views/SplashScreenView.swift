//
//  SplashScreenView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/18/23.
//

import SwiftUI
import Firebase

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State var errorMessage = ""
    @State var showError = false
    @AppStorage("userSigned") var userLogged: Bool = false
    @AppStorage("UserID") var userId : String = ""
    @AppStorage("UserMail") var userMail : String = ""
    @AppStorage("UserPass") var userPass : String = ""
    @StateObject var userService = UserService()
    var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            if isActive {
                InitView()
            } else {
                VStack {
                    VStack {
                        Image("appLogo")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                }
            }
        }
        .overlay(content: {
            NYCBottomErrorAlert(show: $showError, errorTitle: errorMessage) {
                showError.toggle()
                performLogIn()
            }
        })
        .onAppear {
            performLogIn()
        }
    }
    
    func performLogIn() {
        if userLogged {
            Task {
                await userService.logIn(withEmail: userMail,withPass: userPass, completion: {
                    isActive = true
                }) { err in
                    setError(err)
                }
            }
        }
        else {
            print("Not logged")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isActive = true
            }
        }
    }
    
    func setError(_ error: Error) {
        isActive = false
        errorMessage = parseAuthError(error)
        withAnimation {
            showError.toggle()
        }
    }
}

