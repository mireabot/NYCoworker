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

struct LocationDetailView: View {
  @Environment(\.dismiss) var makeDismiss
  @AppStorage("UserID") var userId : String = ""
  @State var currentImage: Int = 0
  @State var addToFavs = false
  @State var showReviewList = false
  @State var showUpdatesList = false
  @State var reportEdit = false
  @State var isLoading = true
  @StateObject private var reviewService = ReviewService()
  @StateObject private var locationService = LocationService()
  @EnvironmentObject var navigationState: NavigationDestinations
  @State private var sheetContentHeight = CGFloat(0)
  var locationData : Location
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      LazyVStack(spacing: -4) {
        GeometryReader { proxy -> AnyView in
          let offset = proxy.frame(in: .global).minY
          
          AnyView(
            NYCImageCarousel(imageUrls: locationData.locationImages)
              .frame(width: UIScreen.main.bounds.width, height: 200 + (offset > 0 ? offset : 0))
              .offset(y: (offset > 0 ? -offset : 0))
          )
        }
        .frame(height: 200)
        
        VStack {
          locationInfo()
          reviews()
          amenities()
          workingHours()
        }
        .padding(.top, 15)
      }
    }
    .fullScreenCover(isPresented: $navigationState.isPresentingReviewSubmission, content: {
      AddReviewView(locationData: locationData).environmentObject(navigationState)
    })
    .sheet(isPresented: $showReviewList, content: {
      ExpandedReviewView(type: .fullList)
        .environmentObject(reviewService)
        .presentationDetents([.fraction(0.95)])
        .presentationDragIndicator(.visible)
    })
    .sheet(isPresented: $showUpdatesList, content: {
      InstructionsExpandedView(locationData: locationData)
        .presentationDetents([.fraction(0.95)])
        .presentationDragIndicator(.visible)
    })
    .toolbarBackground(.white, for: .navigationBar)
    .navigationBarBackButtonHidden()
    .navigationBarTitleDisplayMode(.inline)
    .task {
      AnalyticsManager.shared.log(.locationSelected(locationData.locationID))
      guard reviewService.reviews.isEmpty else { return }
      await reviewService.fetchReviews(locationID: "\(locationData.locationID)", completion: {
        DispatchQueue.main.async {
          isLoading = false
        }
      })
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.arrowBack) {
          makeDismiss()
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        NYCCircleImageButton(size: 24, image: Resources.Images.Settings.rate) {
          Task {
            await locationService.addFavoriteLocation(locationID: locationData.locationID, userID: userId, completion: {
              AnalyticsManager.shared.log(.locationAddedToFavs(locationData.locationID))
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

struct LocationDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LocationDetailView(locationData: Location.mock).environmentObject(NavigationDestinations())
  }
}

extension LocationDetailView { //MARK: - View components
  
  @ViewBuilder
  func locationInfo() -> some View {
    VStack {
      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text(locationData.locationName)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 22))
          HStack(spacing: 1) {
            LocationR.General.pin
              .resizable()
              .frame(width: 18,height: 18)
            Text(locationData.locationAddress)
              .foregroundColor(Resources.Colors.darkGrey)
              .font(Resources.Fonts.regular(withSize: 13))
          }
          HStack(spacing: 3) {
            ForEach(locationData.locationTags,id: \.self) { title in
              NYCBadgeView(badgeType: .withWord, title: title)
            }
          }
        }
        
        Spacer()
        
        NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.openMap) {
          AnalyticsManager.shared.log(.routeButtonPressed(locationData.locationID))
          openInAppleMaps(address: locationData.locationAddress, withName: locationData.locationName)
        }
      }
      
      InstructionsView(firstTabPressed: $showUpdatesList, secondTabPressed: $showReviewList, locationData: locationData)
      
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
      
      if locationData.locationAmenities.isEmpty {
        NYCEmptyView(type: .noAmenities)
          .padding([.leading,.trailing], 16)
      }
      else {
        ScrollView(.horizontal, showsIndicators: false) {
          amenitiesGridView()
            .padding([.leading,.trailing], 16)
        }.disabled(locationData.locationAmenities.count <= 6)
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
      
      if locationData.locationHours.isEmpty {
        NYCEmptyView(type: .noWorkingHours)
          .padding([.leading,.trailing], 16)
      }
      else {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 5) {
            ForEach(locationData.locationHours,id: \.self){ item in
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
      ForEach(locationData.locationAmenities,id: \.self) { item in
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
    AnalyticsManager.shared.log(.reviewOpened(locationData.locationID))
    navigationState.isPresentingReviewSubmission = true
  }
}
