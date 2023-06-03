//
//  HelpSupportView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import StoreKit
import PopupView

struct SupportSettingsView: View {
  @Environment(\.requestReview) var requestReview
  @State private var showFeedback = false
  @State private var showWebsite = false
  var body: some View {
    VStack {
      VStack {
        Image("appLogo")
          .resizable()
          .frame(width: 100, height: 100)
        
        Text("NYCoworker")
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 22))
      }
      .padding(.top, 20)
      .padding(.bottom, 20)
      
      VStack(spacing: 10) {
        NYCSettingsCard(icon: Resources.Images.Settings.manageAccount, title: "Write feedback", action: {
          showFeedback.toggle()
        })
        NYCSettingsCard(icon: Resources.Images.Settings.website, title: "Visit website", action: {
          showWebsite.toggle()
        })
        NYCSettingsCard(icon: Resources.Images.Settings.rate, title: "Rate app", action: {
          requestReview()
        })
      }
      .padding([.leading,.trailing], 16)
      
      NYCSettingsCard(icon: Resources.Images.Settings.faq, title: "FAQ", action: {})
        .padding(.top, 50)
        .padding([.leading,.trailing], 16)
      
      Spacer()
    }
    .popup(isPresented: $showWebsite, view: {
      SafariBottomView(url: Resources.websiteURL)
      
    }, customize: {
      $0
        .type(.toast)
        .isOpaque(true)
        .backgroundColor(Color.black.opacity(0.3))
        .position(.bottom)
        .closeOnTap(false)
        .closeOnTapOutside(false)
        .dragToDismiss(true)
        .animation(.spring(response: 0.4, blendDuration: 0.2))
    })
    .fullScreenCover(isPresented: $showFeedback) {
      WriteFeedbackView()
    }
  }
}

struct HelpSupportView_Previews: PreviewProvider {
  static var previews: some View {
    SupportSettingsView()
  }
}

extension SupportSettingsView { //MARK: - Functions
  func openWebsite() {
    if let url = URL(string: "https://www.nycoworker.com/") {
      UIApplication.shared.open(url)
    }
  }
}
