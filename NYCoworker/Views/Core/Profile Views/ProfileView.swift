//
//  ProfileView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                /// Profile section
                VStack(alignment: .center, spacing: 5) {
                    Circle()
                        .frame(width: 100, height: 100)
                    Text("Michael")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 20))
                    Text("Coworker from 2023")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 13))
                }
                .padding(.top, 25)
                
                VStack(alignment: .leading) {
                    Text("Settings")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 16))
                    
                    ForEach(settigsData) { data in
                        VStack {
                            SettingsCard(data: data)
                                .onTapGesture {
                                    print(data.title)
                                }
                        }
                    }
                }
                .padding([.leading,.trailing], 16)
                
                
                /// Bottom content
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Log out")
                            .foregroundColor(Resources.Colors.actionRed)
                            .font(Resources.Fonts.bold(withSize: 20))
                        Text("Version 1.0")
                            .foregroundColor(Resources.Colors.darkGrey)
                            .font(Resources.Fonts.regular(withSize: 16))
                    }
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.bottom, 30)
            }
            .toolbar {
                NYCHeader(title: "Profile")
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 10)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
