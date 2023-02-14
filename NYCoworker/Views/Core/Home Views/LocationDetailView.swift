//
//  LocationDetailView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import iPages

struct LocationDetailView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var currentImage: Int = 0
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    iPages(selection: $currentImage) {
                        Rectangle().fill(Color.red)
                        Rectangle().fill(Color.blue)
                        Rectangle().fill(Color.gray)
                    }
                    .dotsAlignment(.bottom)
                    .dotsTintColors(currentPage: Resources.Colors.primary, otherPages: Resources.Colors.customGrey)
                    .animated(true)
                    .wraps(true)
                    .frame(height: 250)
                }
                
                /// Location info
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Public Hotel")
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.bold(withSize: 22))
                            HStack(spacing: 1) {
                                LocationR.General.pin
                                    .resizable()
                                    .frame(width: 18,height: 18)
                                Text("691 Eight Avenue, New York, NY 10036")
                                    .foregroundColor(Resources.Colors.darkGrey)
                                    .font(Resources.Fonts.regular(withSize: 13))
                            }
                            Text("Today 10:00am - 9:00pm")
                                .foregroundColor(Resources.Colors.darkGrey)
                                .font(Resources.Fonts.regular(withSize: 13))
                            HStack(spacing: 3) {
                                NYCBadgeView(title: "New")
                                NYCBadgeWithIconView(title: "Open now")
                            }
                        }
                        
                        Spacer()
                        
                        NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.openMap) {
                            
                        }
                        
                    }
                    
                    Rectangle()
                        .foregroundColor(Resources.Colors.customGrey)
                        .frame(height: 1)
                }
                .padding([.leading,.trailing], 16)
                
                /// Reviews
                VStack(alignment: .leading, spacing: 10) {
                    Text("What people say")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 15))
                    ReviewCard()
                    Button {
                        
                    } label: {
                        Text("Write review")
                    }
                    .buttonStyle(NYCActionButtonStyle())
                    
                    Rectangle()
                        .foregroundColor(Resources.Colors.customGrey)
                        .frame(height: 1)

                }
                .padding([.leading,.trailing], 16)
                
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Go back")
                        makeDismiss()
                    } label: {
                        Resources.Images.Navigation.arrowBack
                            .foregroundColor(Resources.Colors.customBlack)
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Save to favorites")
                    } label: {
                        Resources.Images.Settings.rate
                            .foregroundColor(Resources.Colors.customBlack)
                    }

                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        print("Share link")
                    } label: {
                        Resources.Images.Navigation.share
                            .foregroundColor(Resources.Colors.customBlack)
                    }
                }
            }
            .toolbarBackground(.white, for: .navigationBar)
            .navigationBarBackButtonHidden()
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
    }
}
