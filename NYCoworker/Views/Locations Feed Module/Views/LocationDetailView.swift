//
//  LocationDetailView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import PopupView
import CoreLocation
import SDWebImageSwiftUI
import Shimmer
import UIKit

struct LocationDetailView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  var selectedLocation: Location?
  @AppStorage("UserID") var userId : String = ""
  @State var currentImage: Int = 0
  @State var addToFavs = false
  @State var addReviewView = false
  @State var showReviewList = false
  @State var showUpdatesList = false
  @State var reportEdit = false
  @State var isLoading = true
  @StateObject private var reviewService = ReviewService()
  @StateObject private var locationService = LocationService()
  @State private var sheetContentHeight = CGFloat(0)
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(spacing: -5) {
          NYCImageCarousel(imageUrls: selectedLocation?.locationImages ?? Location.mock.locationImages)
            .frame(width: UIScreen.main.bounds.width, height: 230)
          
          VStack {
            locationInfo()
            reviews().id(2)
            amenities().id(3)
            workingHours()
            suggestInfo().padding(.bottom, 15)
          }
          .padding(.top, 15)
        }
      }
      .fullScreenCover(isPresented: $reportEdit, content: {
        SuggestInformationView(locationID: selectedLocation?.locationID ?? Location.mock.locationID, isPresented: $reportEdit)
      })
      .fullScreenCover(isPresented: $addReviewView, content: {
        AddReviewView(isPresented: $addReviewView, locationData: selectedLocation ?? Location.mock)
      })
      .sheet(isPresented: $showReviewList, content: {
        ExpandedReviewView(type: .fullList)
          .environmentObject(reviewService)
          .presentationDetents([.fraction(0.95)])
          .presentationDragIndicator(.visible)
      })
      .toolbarBackground(.white, for: .navigationBar)
      .navigationBarTitleDisplayMode(.inline)
      .task {
        AnalyticsManager.shared.log(.locationSelected(selectedLocation?.locationID ?? Location.mock.locationID))
        guard reviewService.reviews.isEmpty else { return }
        await reviewService.fetchReviews(locationID: "\(selectedLocation?.locationID ?? Location.mock.locationID)", completion: {
          DispatchQueue.main.async {
            isLoading = false
          }
        })
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 20, image: Resources.Images.Navigation.arrowBack) {
            router.nav?.popViewController(animated: true)
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          NYCCircleImageButton(size: 20, image: Resources.Images.Settings.rate) {
            Task {
              await locationService.addFavoriteLocation(locationID: selectedLocation?.locationID ?? Location.mock.locationID, userID: userId, completion: {
                AnalyticsManager.shared.log(.locationAddedToFavs(selectedLocation?.locationID ?? Location.mock.locationID))
                addToFavs.toggle()
              }) { err in
                locationService.setError(err)
              }
            }
          }
        }
      }
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
    }
  }
}

struct LocationDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LocationDetailView().environmentObject(NavigationDestinations())
  }
}

extension LocationDetailView { //MARK: - View components
  
  @ViewBuilder
  func locationInfo() -> some View {
    VStack {
      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text(selectedLocation?.locationName ?? Location.mock.locationName)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 22))
          Text(selectedLocation?.locationAddress ?? Location.mock.locationAddress)
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 13))
        }
        
        Spacer()
        
        NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.openMap) {
          AnalyticsManager.shared.log(.routeButtonPressed(selectedLocation?.locationID ?? Location.mock.locationID))
          guard let selectedLocation = selectedLocation else { return }
          openInAppleMaps(address: selectedLocation.locationAddress, withName: selectedLocation.locationName)
          AnalyticsManager.shared.log(.routeButtonPressed(selectedLocation.locationName))
        }
      }
      
      HStack(spacing: 3) {
        ForEach(selectedLocation?.locationTags ?? Location.mock.locationTags,id: \.self) { title in
          NYCBadgeView(badgeType: .withWord, title: title)
        }
        Spacer()
      }
      
      InstructionsView(firstTabPressed: $showUpdatesList, secondTabPressed: $showReviewList, locationData: selectedLocation ?? Location.mock)
        .padding(.top, 5)
        .sheet(isPresented: $showUpdatesList, content: {
          InstructionsExpandedView(locationData: selectedLocation ?? Location.mock)
            .presentationDetents([.fraction(0.95)])
            .presentationDragIndicator(.visible)
        })
      
      Rectangle()
        .foregroundColor(Resources.Colors.customGrey)
        .frame(height: 1)
    }
    .padding([.leading,.trailing], 16)
  }
  
  @ViewBuilder
  func reviews() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Text("What people say")
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 15))
        Spacer()
      }
      if isLoading {
        NYCEmptyView(type: .noReviews)
          .redacted(reason: .placeholder)
          .shimmering(active: true)
      }
      else {
        if reviewService.reviews.isEmpty {
          NYCEmptyView(type: .noReviews)
        }
        else {
          ReviewCard(variation: .small, data: reviewService.reviews[0])
        }
      }
      
      Button {
        showReviewSubmission()
        AnalyticsManager.shared.log(.reviewOpened(selectedLocation?.locationID ?? Location.mock.locationID))
      } label: {
        Text("Leave your review")
      }
      .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
      .disabled(isLoading)
      
      
      Rectangle()
        .foregroundColor(Resources.Colors.customGrey)
        .frame(height: 1)
      
    }
    .padding([.leading,.trailing], 16)
  }
  
  @ViewBuilder
  func amenities() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Amenities")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 15))
        .padding([.leading,.trailing], 16)
      
      if let amenitiesData = selectedLocation?.locationAmenities, !amenitiesData.isEmpty {
        ScrollView(.horizontal, showsIndicators: false) {
          amenitiesGridView()
            .padding([.leading,.trailing], 16)
        }
        .disabled(amenitiesData.count <= 6)
      }
      else {
        NYCEmptyView(type: .noAmenities)
          .padding([.leading,.trailing], 16)
      }
      
      Rectangle()
        .foregroundColor(Resources.Colors.customGrey)
        .frame(height: 1)
        .padding([.leading,.trailing], 16)
    }
  }
  
  @ViewBuilder
  func workingHours() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Working hours")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 15))
        .padding(.leading, 16)
      
      if let hoursData = selectedLocation?.locationHours, !hoursData.isEmpty {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 5) {
            ForEach(selectedLocation?.locationHours ?? Location.mock.locationHours,id: \.self){ item in
              VStack(spacing: 5) {
                Text(item.weekDay)
                  .foregroundColor(Resources.Colors.darkGrey)
                  .font(Resources.Fonts.regular(withSize: 15))
                Text(item.hours)
                  .foregroundColor(Resources.Colors.customBlack)
                  .font(Resources.Fonts.medium(withSize: 15))
              }
              .padding(10)
              .background(Resources.Colors.customGrey)
              .cornerRadius(5)
            }
          }
          .padding([.leading,.trailing], 16)
        }
      }
      else {
        NYCEmptyView(type: .noWorkingHours)
          .padding([.leading,.trailing], 16)
      }
      
      Rectangle()
        .foregroundColor(Resources.Colors.customGrey)
        .frame(height: 1)
        .padding([.leading,.trailing], 16)
      
    }
  }
  
  @ViewBuilder
  func suggestInfo() -> some View {
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
          Text("Suggest an edit")
            .foregroundColor(Resources.Colors.primary)
            .font(Resources.Fonts.medium(withSize: 15))
        }
        .underline(true, pattern: .solid)
      }
      
    }
    .padding([.leading,.trailing], 16)
  }
  
  @ViewBuilder
  func amenitiesGridView() -> some View {
    let rows = [
      GridItem(.fixed(30),alignment: .leading),
      GridItem(.fixed(30),alignment: .leading)
    ]
    
    LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
      ForEach(selectedLocation?.locationAmenities ?? Location.mock.locationAmenities,id: \.self) { item in
        HStack(alignment: .center, spacing: 5) {
          amenitiesImage(image: item)
            .foregroundColor(Resources.Colors.customBlack)
          Text(item)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.regular(withSize: 15))
        }
        .padding(2)
      }
    }
  }
}

extension LocationDetailView { //MARK: - Functions
  func amenitiesImage(image: String) -> Image {
    switch image {
    case "W/C":
      return LocationR.Amenities.wc
    case "A/C":
      return LocationR.Amenities.ac
    case "Pet friendly":
      return LocationR.Amenities.pets
    case "Rooftop":
      return LocationR.Amenities.rooftop
    case "Charging":
      return LocationR.Amenities.charge
    case "Wi-Fi":
      return LocationR.Amenities.wifi
    case "Quiet space":
      return LocationR.Amenities.silient
    case "Bar":
      return LocationR.Amenities.bar
    case "Work station":
      return LocationR.Amenities.printer
    case "Outdoor space":
      return LocationR.Amenities.outdoor
    case "Food store":
      return LocationR.Amenities.store
    case "Meeting room":
      return LocationR.Amenities.meeting
    case "Accessible":
      return LocationR.Amenities.accessible
    default:
      return LocationR.Amenities.wc
    }
  }
  
  func showReviewSubmission() {
    AnalyticsManager.shared.log(.reviewOpened(selectedLocation?.locationID ?? Location.mock.locationID))
    addReviewView.toggle()
  }
}
