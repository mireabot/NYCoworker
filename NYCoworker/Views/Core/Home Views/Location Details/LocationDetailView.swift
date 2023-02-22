//
//  LocationDetailView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import iPages
import PopupView

struct LocationDetailView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var showMapChoice = false
    @State var currentImage: Int = 0
    @State var addToFavs = false
    @State var showReviewCard = false
    @State var showReviewView = false
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
                locationInfo
                
                /// Reviews
                reviews
                
                ///Amenities list
                amenities
                
                ///Working hours
                workingHours
                
                ///Suggest info
                suggestInfo
                
            }
            .hideTabbar(shouldHideTabbar: true)
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
//                        print("Save to favorites")
                        addToFavs.toggle()
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
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showReviewView, content: {
                AddReviewView()
            })
            .popup(isPresented: $showMapChoice) {
                MapChoiceView()
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .closeOnTap(false)
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.4))
            }
            .popup(isPresented: $showReviewCard) {
                ExpandedReviewView()
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.4))
            }
            .popup(isPresented: $addToFavs) {
                NYCAlertView(title: "Added to favorites", alertStyle: .small)
            } customize: {
                $0
                    .isOpaque(true)
                    .autohideIn(1.5)
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring(response: 0.4, blendDuration: 0.2))
            }
        }
    }
    
    var locationInfo: some View {
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
                        NYCBadgeView(badgeType: .withWord, title: "New")
                        NYCBadgeView(badgeType: .workingHours, title: "Open now")
                    }
                }
                
                Spacer()
                
                NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.openMap) {
                    showMapChoice.toggle()
                }
                
            }
            
            Rectangle()
                .foregroundColor(Resources.Colors.customGrey)
                .frame(height: 1)
        }
        .padding([.leading,.trailing], 16)
    }
    
    var reviews: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("What people say")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 15))
            ReviewCard(variation: .small)
                .onTapGesture {
                    showReviewCard.toggle()
                }
            Button {
                withAnimation(.spring()) {
                    showReviewView.toggle()
                }
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
    
    var amenities: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Place amenities")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 15))
            
            AmenitiesGridView()
            
            Rectangle()
                .foregroundColor(Resources.Colors.customGrey)
                .frame(height: 1)
            
        }
        .padding([.leading,.trailing], 16)
    }
    
    var workingHours: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Working hours")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 15))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(hoursData){ item in
                        WorkingHoursCard(data: item)
                    }
                }
            }
            
            Rectangle()
                .foregroundColor(Resources.Colors.customGrey)
                .frame(height: 1)
            
        }
        .padding([.leading,.trailing], 16)
    }
    
    var suggestInfo: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Found missing information?")
                .foregroundColor(Resources.Colors.darkGrey)
                .font(Resources.Fonts.regular(withSize: 15))
            
            Button {
                
            } label: {
                HStack(spacing: 5) {
                    Image("edit-account")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Resources.Colors.primary)
                    Text("Make edit")
                        .foregroundColor(Resources.Colors.primary)
                        .font(Resources.Fonts.bold(withSize: 15))
                }
            }

        }
        .padding([.leading,.trailing], 16)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
    }
}


struct AmenitiesGridView: View {

    let rows = [
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading)
    ]

    var body: some View {
        LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
            ForEach(amenityData) { item in
                AmenityCard(data: item)
            }
        }
        .frame(height: 80)
    }
}

struct HoursGridView: View {

    let rows = [
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
                ForEach(hoursData) { item in
                    HStack {
                        Text("\(item.day) - \(item.hours)")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(height: 80)
        }
    }
}