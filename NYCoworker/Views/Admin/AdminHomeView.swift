//
//  AdminHomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/20/23.
//

import SwiftUI

struct AdminHomeView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    NavigationLink(destination: AdminLocationView()) {
                        HStack(alignment: .center) {
                            NYCCircleImageButton(size: 20, image: Resources.Images.Social.mark) {
                                
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Manage locations")
                                    .foregroundColor(Resources.Colors.customBlack)
                                    .font(Resources.Fonts.bold(withSize: 15))
                                Text("Add new locations to database")
                                    .foregroundColor(Resources.Colors.darkGrey)
                                    .font(Resources.Fonts.regular(withSize: 13))
                            }
                            .padding(.leading, 5)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadius(5)
                        .padding([.leading,.trailing], 16)
                    }
                    
                    HStack(alignment: .center) {
                        NYCCircleImageButton(size: 20, image: Resources.Images.Settings.manageNotifications) {
                            
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Send remote notifications")
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.bold(withSize: 15))
                            Text("Create push notification for users")
                                .foregroundColor(Resources.Colors.darkGrey)
                                .font(Resources.Fonts.regular(withSize: 13))
                        }
                        .padding(.leading, 5)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(5)
                    .padding([.leading,.trailing], 16)
                }
            }
            .scrollDisabled(true)
            .toolbarBackground(.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NYCHeader(title: "Admin dashboard")
                }
            }
        }
    }
}

struct AdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AdminHomeView()
    }
}
