//
//  LocationDetailView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import iPages
import PopupView
import CoreLocation
import SDWebImageSwiftUI

struct LocationDetailView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var selectDetent : PresentationDetent = .bottom
    @State var showMapChoice = false
    @State var currentImage: Int = 0
    @State var addToFavs = false
    @State var showReviewView = false
    @State var reportEdit = false
    @State var reportSubmitted = false
    @State var isLoading = true
    @StateObject private var reviewService = ReviewService()
    var locationData : Location
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                iPages(selection: $currentImage) {
                    ForEach(locationData.locationImages,id: \.self) { image in
                        WebImage(url: image).placeholder {
                            Image("load")
                                .resizable()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    }
                }
                .dotsAlignment(.bottom)
                .dotsTintColors(currentPage: Resources.Colors.primary, otherPages: Resources.Colors.customGrey)
                .animated(true)
                .wraps(true)
                .frame(width: UIScreen.main.bounds.width, height: 250)
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
            //                suggestInfo
            
        }
        .task {
            guard reviewService.reviews.isEmpty else { return }
            await reviewService.fetchReviews(locationID: "\(locationData.locationID)", completion: {
                print("Reviews fetched")
                DispatchQueue.main.async {
                    isLoading = false
                }
            })
        }
        .hideTabbar(shouldHideTabbar: true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    makeDismiss()
                } label: {
                    Resources.Images.Navigation.arrowBack
                        .foregroundColor(Resources.Colors.customBlack)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
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
        .fullScreenCover(isPresented: $reportEdit, content: {
            ReportEditView(showAlert: $reportSubmitted)
        })
        .sheet(isPresented: $showReviewView, content: {
            ExpandedReviewView(type: .fullList)
                .environmentObject(reviewService)
                .presentationDetents(
                    [.mediumBottomBar, .largeBottomBar],
                    selection: $selectDetent
                )
        })
        .sheet(isPresented: $showMapChoice, content: {
            MapChoiceView(geoPoint: CLLocationCoordinate2D(latitude: locationData.locationCoordinates.latitude, longitude: locationData.locationCoordinates.longitude))
                .presentationDetents(
                    [.bottom],
                    selection: $selectDetent
                )
        })
        .popup(isPresented: $addToFavs) {
            NYCAlertNotificationView(alertStyle: .addedToFavorites)
        } customize: {
            $0
                .isOpaque(true)
                .autohideIn(1.5)
                .type(.floater())
                .position(.bottom)
                .animation(.spring(response: 0.4, blendDuration: 0.2))
        }
        .popup(isPresented: $reportSubmitted) {
            NYCAlertNotificationView(alertStyle: .reportSubmitted)
        } customize: {
            $0
                .isOpaque(true)
                .autohideIn(1.5)
                .type(.floater())
                .position(.top)
                .animation(.spring(response: 0.4, blendDuration: 0.2))
        }
    }
    
    var locationInfo: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(locationData.locationName)
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 22))
                    HStack(spacing: 1) {
                        LocationR.General.pin
                            .resizable()
                            .frame(width: 18,height: 18)
                        Text(locationData.locationAddress)
                            .foregroundColor(Resources.Colors.darkGrey)
                            .font(Resources.Fonts.regular(withSize: 13))
                    }
//                    Text("Today 10:00am - 9:00pm")
//                        .foregroundColor(Resources.Colors.darkGrey)
//                        .font(Resources.Fonts.regular(withSize: 13))
                    HStack(spacing: 3) {
                        ForEach(locationData.locationTags,id: \.self) { title in
                            NYCBadgeView(badgeType: .withWord, title: title)
                        }
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
            HStack {
                Text("What people say")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 15))
                Spacer()
                Button {
                    showReviewView.toggle()
                } label: {
                    Text("See all")
                        .foregroundColor(Resources.Colors.primary)
                        .font(Resources.Fonts.bold(withSize: 13))
                }
                .opacity(reviewService.reviews.count <= 1 ? 0 : 1)
                
            }
            if isLoading {
                ReviewEmptyView()
            }
            else {
                if reviewService.reviews.isEmpty {
                    ReviewEmptyView()
                }
                else {
                    ReviewCard(variation: .small, data: reviewService.reviews[0])
                }
            }
            
            Rectangle()
                .foregroundColor(Resources.Colors.customGrey)
                .frame(height: 1)
            
        }
        .padding([.leading,.trailing], 16)
    }
    
    var amenities: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Amenities")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 15))
            
            amenitiesGridView()
            
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
                .padding(.leading, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(locationData.locationHours,id: \.self){ item in
                        VStack(spacing: 5) {
                            Text(item.weekDay)
                                .foregroundColor(Resources.Colors.darkGrey)
                                .font(Resources.Fonts.regular(withSize: 15))
                            Text(item.hours)
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.bold(withSize: 15))
                        }
                        .padding(10)
                        .background(Resources.Colors.customGrey)
                        .cornerRadius(5)
                    }
                }
                .padding([.leading,.trailing], 16)
            }
            
            Rectangle()
                .foregroundColor(Resources.Colors.customGrey)
                .frame(height: 1)
                .padding([.leading,.trailing], 16)
            
        }
    }
    
    var suggestInfo: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Found missing information?")
                .foregroundColor(Resources.Colors.darkGrey)
                .font(Resources.Fonts.regular(withSize: 15))
            
            Button {
                reportEdit.toggle()
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
    
    @ViewBuilder
    func amenitiesGridView() -> some View {
        let rows = [
            GridItem(.flexible(),alignment: .leading),
            GridItem(.flexible(),alignment: .leading)
        ]
        
        LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
            ForEach(locationData.locationAmenities,id: \.self) { item in
                HStack(alignment: .center, spacing: 5) {
                    Image(image(image: item))
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(item)
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 15))
                }
                .padding(2)
            }
        }
        .frame(height: 80)
    }
    
    func image(image: String) -> String {
        switch image {
        case "W/C":
            return "WC"
        case "A/C":
            return "AC"
        case "Pets allowed":
            return "Pets"
        default:
            return image
        }
    }
}

//struct LocationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationDetailView()
//    }
//}
