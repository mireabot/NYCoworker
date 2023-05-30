//
//  HelpSupportView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import StoreKit

struct SupportSettingsView: View {
    @Environment(\.requestReview) var requestReview
    @State private var showFeedback = false
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
                    openWebsite()
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
