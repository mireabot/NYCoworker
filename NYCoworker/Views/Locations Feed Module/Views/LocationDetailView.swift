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
  var selectedLocation: Location
  @AppStorage("UserID") var userId : String = ""
  @State var currentImage: Int = 0
  @State private var addToFavorites = false
  @State private var removeFromFavorites = false
  @State private var addReviewView = false
  @State private var showReviewList = false
  @State private var showUpdatesList = false
  @State private var reportEdit = false
  @State private var isLoading = true
  @State private var isFavorite = false
  @StateObject private var userService = UserService()
  @StateObject private var locationStore = LocationStore()
  @State private var sheetContentHeight = CGFloat(0)
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(spacing: -5) {
          NYCImageCarousel(imageUrls: selectedLocation.locationImages)
            .frame(width: UIScreen.main.bounds.width, height: 230)
          
          VStack {
            locationInfo()
            reviews()
            amenities()
            workingHours()
            suggestInfo().padding(.bottom, 15)
          }
          .padding(.top, 15)
        }
      }
      .fullScreenCover(isPresented: $reportEdit, content: {
        SuggestInformationView(locationID: selectedLocation.locationID, isPresented: $reportEdit)
      })
      .fullScreenCover(isPresented: $addReviewView, content: {
        AddReviewView(isPresented: $addReviewView, locationData: selectedLocation)
      })
      .sheet(isPresented: $showReviewList, content: {
        ReviewListView()
          .environmentObject(locationStore)
          .presentationDetents([.fraction(0.95)])
          .presentationDragIndicator(.visible)
      })
      .sheet(isPresented: $showUpdatesList, content: {
        HighlightsListView(locationData: selectedLocation)
          .presentationDetents([.fraction(0.95)])
          .presentationDragIndicator(.visible)
      })
      .toolbarBackground(.white, for: .navigationBar)
      .navigationBarTitleDisplayMode(.inline)
      .task {
        AnalyticsManager.shared.log(.locationSelected(selectedLocation.locationID))
        await fetchAllReviews()
        await checkForFavorites(locationID: selectedLocation.locationID)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 20, image: Resources.Images.Navigation.arrowBack) {
            router.nav?.popViewController(animated: true)
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          NYCCircleImageButton(size: 20, image: isFavorite ? Resources.Images.Settings.rateFilled : Resources.Images.Settings.rate) {
            Task {
              if isFavorite {
                await removeLocationFromFavorites(locationID: selectedLocation.locationID)
              }
              else {
                await addLocationToFavorites(locationID: selectedLocation.locationID)
              }
            }
          }
        }
      }
      .popup(isPresented: $addToFavorites) {
        NYCAlertNotificationView(alertStyle: .addedToFavorites)
      } customize: {
        $0
          .isOpaque(true)
          .autohideIn(1.5)
          .type(.floater())
          .position(.bottom)
          .dismissCallback {
            isFavorite = true
          }
          .animation(.spring(response: 0.4, blendDuration: 0.2))
      }
      .popup(isPresented: $removeFromFavorites) {
        NYCAlertNotificationView(alertStyle: .removedFromFavorites)
      } customize: {
        $0
          .isOpaque(true)
          .autohideIn(1.5)
          .type(.floater())
          .position(.bottom)
          .dismissCallback {
            isFavorite = false
          }
          .animation(.spring(response: 0.4, blendDuration: 0.2))
      }
    }
  }
}

struct LocationDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LocationDetailView(selectedLocation: .mock).environmentObject(NYCNavigationViewsRouter())
  }
}

extension LocationDetailView { //MARK: - View components
  
  @ViewBuilder
  func locationInfo() -> some View {
    VStack {
      HStack {
        VStack(alignment: .leading, spacing: 2) {
          Text(selectedLocation.locationName)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 22))
          Text(selectedLocation.locationAddress)
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 13))
        }
        
        Spacer()
        
        NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.openMap) {
          AnalyticsManager.shared.log(.routeButtonPressed(selectedLocation.locationID))
          openInAppleMaps(address: selectedLocation.locationAddress, withName: selectedLocation.locationName)
          AnalyticsManager.shared.log(.routeButtonPressed(selectedLocation.locationName))
        }
      }
      
      HStack(spacing: 3) {
        ForEach(selectedLocation.locationTags, id: \.self) { title in
          NYCBadgeView(badgeType: .withWord, title: title)
        }
        Spacer()
      }
      
      if !(selectedLocation.locationUpdates?.isEmpty ?? true) {
        NYCHighlightsCard {
          showUpdatesList.toggle()
        }
      }
      
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
        
        Button {
          showReviewList.toggle()
        } label: {
          Text("See all")
            .foregroundColor(Resources.Colors.primary)
            .font(Resources.Fonts.medium(withSize: 15))
        }
        .disabled(isLoading)

      }
      if isLoading {
        NYCEmptyView(type: .noReviews)
          .redacted(reason: .placeholder)
          .shimmering(active: true)
      }
      else {
        if locationStore.reviews.isEmpty {
          NYCEmptyView(type: .noReviews)
        }
        else {
          NYCReviewCard(variation: .small, data: locationStore.reviews[0])
        }
      }
      
      Button {
        showReviewSubmission()
        AnalyticsManager.shared.log(.reviewOpened(selectedLocation.locationID))
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
      
      if !selectedLocation.locationAmenities.isEmpty {
        ScrollView(.horizontal, showsIndicators: false) {
          amenitiesGridView()
            .padding([.leading,.trailing], 16)
        }
        .disabled(selectedLocation.locationAmenities.count <= 6)
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
      
      if !selectedLocation.locationHours.isEmpty {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 5) {
            ForEach(selectedLocation.locationHours, id: \.self){ item in
              NYCWorkingHoursCard(data: item)
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
      ForEach(selectedLocation.locationAmenities, id: \.self) { item in
        NYCAmenityCard(data: item)
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
    AnalyticsManager.shared.log(.reviewOpened(selectedLocation.locationID))
    addReviewView.toggle()
  }
  
  private func fetchAllReviews() async {
    await locationStore.fetchReviews(for: selectedLocation.locationID, completion: { result in
      switch result {
      case .success:
        isLoading = false
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }
  
  private func checkForFavorites(locationID id: String) async {
    await userService.fetchUser(documentId: userId, completion: {
      Task {
        if userService.user.favoriteLocations.contains(id) {
          isFavorite = true
        }
        else {
          isFavorite = false
        }
      }
    })
  }
  
  private func removeLocationFromFavorites(locationID id: String) async {
    await LocationService.shared.removeLocationFromFavorites(for: userId, with: id) { result in
      switch result {
      case .success:
        AnalyticsManager.shared.log(.locationRemovedFromFavs(id))
        removeFromFavorites.toggle()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func addLocationToFavorites(locationID id: String) async {
    await LocationService.shared.addFavoriteLocation(locationID: id, userID: userId, completion: { result in
      switch result {
      case .success:
        AnalyticsManager.shared.log(.locationAddedToFavs(id))
        addToFavorites.toggle()
      case .failure(let error):
        print(firestoreError(forError: error))
      }
    })
  }
}
