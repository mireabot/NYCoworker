//
//  AccoutSetupView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/2/23.
//

import SwiftUI
import PopupView

struct AccoutSetupView: View {
    @State var currentStep = 0
    @StateObject var model = UserRegistrationModel()
    @AppStorage("userSigned") var userLogged: Bool = false
    @State var showLoad = false
    var body: some View {
        VStack {
            switch currentStep {
            case 0:
                ProfileSetup().environmentObject(model)
            case 1:
                PersonTypeSetup().environmentObject(model)
            case 2:
                GenderTypeSetup().environmentObject(model)
            case 3:
                NotificationPermission()
            case 4:
               GeopositionPermission()
            default:
                EmptyView()
            }
            
            navBar
        }
        .navigationBarBackButtonHidden()
        .popup(isPresented: $showLoad) {
            LoadingBottomView(title: "Setting you up")
        } customize: {
            $0
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        }
    }
    
    var navBar: some View {
        HStack {
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    NavigationDotsView(index: index, page: self.$currentStep)
                }
            }
            Spacer()
            HStack {
                NYCNavigationButton(type: .back) {
                    self.currentStep -= 1
                }
                .opacity(self.currentStep > 0 ? 1 : 0)
                
                NYCNavigationButton(type: .next) {
                    if self.currentStep == 4 {
                        withAnimation(.spring()) {
                            showLoad.toggle()
                            model.createUser {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showLoad.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        userLogged = true
                                    }
                                }
                            }
                        }
                    }
                    else {
                        self.currentStep += 1
                    }
                }
                .disabled(model.name.isEmpty || model.occupation.isEmpty ? true : false)
                .opacity(self.currentStep == 5 ? 0 : 1)
            }
        }
        .padding(16)
        .background(Color.white)
    }
    
}

struct AccoutSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccoutSetupView()
    }
}