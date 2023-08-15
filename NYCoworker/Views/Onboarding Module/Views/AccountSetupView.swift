//
//  AccoutSetupView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/2/23.
//

import SwiftUI
import PopupView

struct AccountSetupView: View {
  @State var currentStep = 1
  @StateObject var model = UserRegistrationModel()
  @State var showLoad = false
  var body: some View {
    VStack {
      switch currentStep {
      case 1:
        ProfileSetup().environmentObject(model)
      case 2:
        PersonTypeSetup().environmentObject(model)
      case 3:
        GenderTypeSetup().environmentObject(model)
      case 4:
        NotificationPermission().environmentObject(model)
      case 5:
        GeopositionPermission().environmentObject(model)
      default:
        EmptyView()
      }
    }
    .safeAreaInset(edge: .bottom, content: {
      
      HStack {
        Spacer()
        HStack {
          NYCNavigationButton(type: .back) {
            self.currentStep -= 1
          }
          .opacity(self.currentStep > 1 ? 1 : 0)
          
          Button {
            if self.currentStep == 5 {
              withAnimation(.spring()) {
                showLoad.toggle()
                let email = "\(model.randomString(length: 7))"
                let password = "\(model.randomString(length: 10))"
                AnalyticsManager.shared.log(.accountCreated)
                model.createUser(mail: email, pass: password) {
                  DispatchQueue.main.async {
                    showLoad.toggle()
                  }
                }
              }
            }
            else {
              self.currentStep += 1
            }
          } label: {
            Text("Next")
          }
          .buttonStyle(NYCNavigationButtonStyle())
          .disabled(checkButton())
        }
      }
      .padding([.leading,.trailing], 16)
      .padding(.bottom, 5)
      .background(Color.white)
    })
    .navigationBarBackButtonHidden()
    .navigationBarTitleDisplayMode(.inline)
    .toolbar(content: {
      ToolbarItem(placement: .principal) {
        NYCSegmentProgressBar(value: currentStep, maximum: 5)
      }
    })
    .overlay(content: {
      LoadingBottomView(title: "Setting you up", show: $showLoad)
    })
  }
}

struct AccoutSetupView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AccountSetupView()
    }
  }
}

extension AccountSetupView {
  func checkButton() -> Bool {
    switch currentStep {
    case 1: return model.name.isEmpty || ((model.profileImage?.isEmpty) == nil) || model.occupation.isEmpty
    case 2: return false
    case 3: return false
    case 4: return !model.notificationsPermissionGranted
    case 5: return !model.geolocationPermissionGranted
    default:
      return false
    }
  }
}
