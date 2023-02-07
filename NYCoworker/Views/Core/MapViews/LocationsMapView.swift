//
//  LocationsMapView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI

struct LocationsMapView: View {
    @Environment(\.dismiss) var makeDismiss
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.blue.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 50) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Public Hotel")
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.bold(withSize: 22))
                            Text("691 Eight Avenue, New York, NY 10036")
                                .foregroundColor(Resources.Colors.darkGrey)
                                .font(Resources.Fonts.regular(withSize: 13))
                            Text("Today 10:30am - 11:00pm")
                                .foregroundColor(Resources.Colors.darkGrey)
                                .font(Resources.Fonts.regular(withSize: 13))
                                .padding(.bottom, 5)
                        }
                        Spacer()
                        Text("1.7 mi")
                            .foregroundColor(Resources.Colors.darkGrey)
                            .font(Resources.Fonts.regular(withSize: 13))
                    }
                    
                    NYCActionButton(action: {
                        
                    }, text: "View Details")
                }
                .padding([.leading,.trailing], 16)
                .padding(.top, 18)
                .padding(.bottom, 35)
                .background(Color.white)
                .frame(maxWidth: .infinity, alignment: .bottom)
                .clipShape(RoundedCorner(radius: 16, corners: [.topLeft, .topRight]))
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.close) {
                        makeDismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.location) {
                        
                    }
                }
            }
        }
    }
}

struct LocationsMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsMapView()
    }
}
