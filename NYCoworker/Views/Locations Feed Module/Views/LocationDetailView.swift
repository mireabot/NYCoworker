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
  @State var selectDetent : PresentationDetent = .bottom
  @State var currentImage: Int = 0
  @State var addToFavs = false
  @State var showReviewView = false
  @State var reportEdit = false
  @State var isLoading = true
  @StateObject private var reviewService = ReviewService()
  var locationData : Location
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      LazyVStack(spacing: -4) {
        GeometryReader { proxy -> AnyView in
          let offset = proxy.frame(in: .global).minY
          
          return AnyView(
            NYCImageCarousel(imageUrls: locationData.locationImages)
              .frame(width: UIScreen.main.bounds.width, height: 200 + (offset > 0 ? offset : 0))
              .offset(y: (offset > 0 ? -offset : 0))
          )
        }
        .frame(height: 200)
        
        VStack {
          locationInfo
          reviews
          amenities
          workingHours
        }
        .padding(.top, 15)
      }
    }
    .toolbarBackground(.hidden, for: .navigationBar)
    .navigationBarBackButtonHidden()
    .navigationBarTitleDisplayMode(.inline)
    .task {
      guard reviewService.reviews.isEmpty else { return }
      await reviewService.fetchReviews(locationID: "\(locationData.locationID)", completion: {
        print("Reviews fetched")
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
          addToFavs.toggle()
        }
      }
    }
    .toolbarBackground(.white, for: .navigationBar)
    .sheet(isPresented: $showReviewView, content: {
      ExpandedReviewView(type: .fullList)
        .environmentObject(reviewService)
        .presentationDetents(
          [.mediumBottomBar, .largeBottomBar],
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
          openInAppleMaps(address: locationData.locationAddress, withName: locationData.locationName)
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
        .opacity(reviewService.reviews.count == 0 ? 0 : 1)
        
      }
      if isLoading {
        ReviewEmptyView()
          .redacted(reason: .placeholder)
          .shimmering(active: true)
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

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
      LocationDetailView(locationData: Location.mock)
    }
}
