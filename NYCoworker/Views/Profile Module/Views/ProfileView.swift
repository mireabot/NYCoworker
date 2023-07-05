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
  @State var showPopup = false
  @AppStorage("UserID") var userId : String = ""
  @EnvironmentObject var userService : UserService
  @State private var sheetContentHeight = CGFloat(0)
  var body: some View {
    NavigationStack {
      VStack {
        VStack {
          profileHeader()
          
          settingsView()
          
          profileFooter()
        }
        Spacer()
      }
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
          .presentationDragIndicator(.visible)
      }
      .applyNavigationTransition()
      .navigationDestination(for: SettingsModel.self, destination: { settingsData in
        SettingsView(title: settingsData.title).environmentObject(userService)
      })
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCHeader(title: "Profile")
        }
      }
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
      Text("Coworker from 2023")
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
      
      ForEach(settigsData, id: \.title) { data in
        VStack {
          NavigationLink(value: data) {
            SettingsCard(data: data)
          }
        }
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
          showPopup.toggle()
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
    ProfileView().environmentObject(UserService())
  }
}

