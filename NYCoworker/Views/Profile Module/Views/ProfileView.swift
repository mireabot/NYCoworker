//
//  ProfileView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI
import Shimmer
import SDWebImageSwiftUI

struct ProfileView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  @State var showPopup = false
  @State var showSuggestionSheet = false
  @AppStorage("UserID") var userId : String = ""
  @StateObject var userService = UserService()
  @State private var sheetContentHeight = CGFloat(0)
  var body: some View {
    NavigationView(content: {
      VStack {
        VStack {
          profileHeader()
          
          settingsView()
          
          NYCPromoBanner(bannerType: .suggestLocation, action: {
            DispatchQueue.main.async {
              showSuggestionSheet.toggle()
              AnalyticsManager.shared.log(.locationSuggestionWasOpened)
            }
          })
          .padding(.top, 15)
          
          profileFooter()
        }
        Spacer()
      }
      .task {
        await userService.fetchUser(documentId: userId) {
          print("User fetched with id \(userService.user.userID)")
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCHeader(title: "Profile")
        }
      }
    })
    .fullScreenCover(isPresented: $showSuggestionSheet, content: {
      LocationSuggestionStartingView(showView: $showSuggestionSheet)
    })
    .sheet(isPresented: $showPopup) {
      DeleteAccountBottomView(isVisible: $showPopup)
        .background {
          GeometryReader { proxy in
            Color.clear
              .task {
                sheetContentHeight = proxy.size.height
              }
          }
        }
        .presentationDetents([.height(sheetContentHeight)])
    }
  }
}

extension ProfileView { //MARK: - Profile components
  @ViewBuilder
  func profileHeader()-> some View {
    VStack(alignment: .center, spacing: 5) {
      WebImage(url: userService.user.avatarURL).placeholder {
        Image("emptyImage")
          .resizable()
      }
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 100, height: 100)
      .clipShape(Circle())
      
      Text(userService.user.name)
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 20))
      Text("Coworker since 2023")
        .foregroundColor(Resources.Colors.darkGrey)
        .font(Resources.Fonts.regular(withSize: 13))
    }
  }
  
  @ViewBuilder
  func settingsView()-> some View {
    VStack(alignment: .leading) {
      Text("Settings")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 16))
      
      VStack {
        NYCSettingsCard(type: .manageAccount, action: {
          DispatchQueue.main.async {
            router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(AccountSettingsView(currentUser: userService.user)))
          }
        })
        NYCSettingsCard(type: .help, action: {
          DispatchQueue.main.async {
            router.pushTo(view: NYCNavigationViewBuilder.builder.makeView(SupportSettingsView()))
          }
        })
      }
    }
    .padding([.leading,.trailing], 16)
  }
  
  @ViewBuilder
  func profileFooter()-> some View {
    HStack {
      VStack(alignment: .leading, spacing: 5) {
        Button {
          AnalyticsManager.shared.log(.deleteButtonPressed)
          DispatchQueue.main.async {
            showPopup.toggle()
          }
        } label: {
          Text("Delete account")
            .foregroundColor(Resources.Colors.actionRed)
            .font(Resources.Fonts.medium(withSize: 20))
        }
        
        Text("Version 1.0")
          .foregroundColor(Resources.Colors.darkGrey)
          .font(Resources.Fonts.regular(withSize: 16))
      }
      
      Spacer()
    }
    .padding(.leading, 16)
    .padding(.top, 10)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

