//
//  HelpSupportView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import StoreKit

struct SupportSettingsView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  @Environment(\.requestReview) var requestReview
  @State private var showWebsite = false
  var body: some View {
    NavigationView {
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
          NYCSettingsCard(type: .writeFeedback, action: {
            AnalyticsManager.shared.log(.feedbackOpened)
            DispatchQueue.main.async {
              router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(WriteFeedbackView()))
            }
          })
          NYCSettingsCard(type: .visitWebsite, action: {
            AnalyticsManager.shared.log(.websiteOpened)
            showWebsite.toggle()
          })
          NYCSettingsCard(type: .rateApp, action: {
            requestReview()
          })
        }
        .padding([.leading,.trailing], 16)
        Spacer()
      }
      .sheet(isPresented: $showWebsite, content: {
        SafariView(url: .constant(Resources.websiteURL))
      })
      .toolbarBackground(.white, for: .navigationBar)
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            DispatchQueue.main.async {
              router.nav?.popViewController(animated: true)
            }
          } label: {
            Resources.Images.Navigation.arrowBack
              .foregroundColor(Resources.Colors.primary)
          }
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
          Text(Strings.Settings.helpSupport)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 17))
        }
      })
    }
  }
}

struct HelpSupportView_Previews: PreviewProvider {
  static var previews: some View {
    SupportSettingsView()
  }
}
