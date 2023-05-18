//
//  AddReviewView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/21/23.
//

import SwiftUI
import PopupView
import SDWebImageSwiftUI
import Firebase

struct AddReviewView: View {
  @Environment(\.dismiss) var makeDismiss
  @State var visitDate = Date()
  @State var reviewText = ""
  @State var reviewType : Review.ReviewType = .pos
  @State var showDate = false
  @State private var showLoader = false
  @State private var showAlert = false
  @FocusState private var fieldIsFocused: Bool
  @StateObject var reviewService = ReviewService()
  let locationData: Location
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          reviewTypeControl()
            .padding(.top, 10)
          
          locationCard()
            .padding([.leading,.trailing], 16)
            .padding(.top, 10)
        }
        
        VStack(alignment: .leading, spacing: 15) {
          calendarView()
          reviewInfo()
        }
        .padding([.leading,.trailing], 16)
        .padding(.top, 10)
      }
      .popup(isPresented: $showAlert) {
        NYCAlertNotificationView(alertStyle: .reviewUploaded)
      } customize: {
        $0
          .isOpaque(true)
          .autohideIn(1.5)
          .type(.floater())
          .position(.top)
          .animation(.spring(response: 0.4, blendDuration: 0.2))
          .dismissCallback {
            reviewText = ""
          }
      }
      .popup(isPresented: $showDate, view: {
        CalendarBottomView(showDate: $showDate, date: $visitDate)
        
      }, customize: {
        $0
          .type(.toast)
          .isOpaque(true)
          .backgroundColor(Color.black.opacity(0.3))
          .position(.bottom)
          .closeOnTap(false)
          .closeOnTapOutside(false)
      })
      .onTapGesture {
        fieldIsFocused = false
      }
      .safeAreaInset(edge: .bottom, content: {
        Button {
          showLoader = true
          Task {
            await reviewService.createReview(from:
                                              Review(id: locationData.locationID,
                                                     datePosted: Timestamp(date: Date()),
                                                     dateVisited: Timestamp(date: visitDate),
                                                     text: reviewText,
                                                     type: reviewType,
                                                     userName: Resources.userName,
                                                     userImage: Resources.userImageUrl),
                                             location: locationData,
                                             completion: {
              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showLoader = false
                showAlert.toggle()
              }
            })
          }
        } label: {
          Text("Submit")
        }
        .disabled(reviewText == "" ? true : false)
        .buttonStyle(NYCActionButtonStyle(showLoader: $showLoader))
        .padding([.top,.bottom], 10)
        .padding([.leading,.trailing], 16)
      })
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
      .toolbarBackground(.white, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .principal) {
          NYCHeader(title: "Write a review", headerType: .center)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          NYCCircleImageButton(size: 18, image: Resources.Images.Navigation.close) {
            makeDismiss()
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func reviewTypeControl() -> some View {
    NYCSegmentControl(title: $reviewType)
  }
  
  @ViewBuilder
  func locationCard() -> some View {
    HStack {
      HStack(alignment: .center, spacing: 10) {
        WebImage(url: locationData.locationImages[0], options: .delayPlaceholder).placeholder {
          Image("load")
            .resizable()
            .aspectRatio(contentMode: .fill)
        }
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 80, height: 60)
        .cornerRadius(5)
        
        VStack(alignment: .leading, spacing: 2) {
          Text(locationData.locationName)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.regular(withSize: 15))
          Text(locationData.locationAddress)
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 13))
        }
      }
      Spacer()
    }
  }
  
  @ViewBuilder
  func calendarView() -> some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("Date visited")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 15))
      
      Text(visitDate.toString("MMMM d"))
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.medium(withSize: 20))
        .onTapGesture {
          showDate.toggle()
        }
    }
  }
  
  @ViewBuilder
  func reviewInfo() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("How you can describe your visit?")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 15))
      
      NYCResizableTextField(message: $reviewText, characterLimit: 300, placeHolder: "It was a good place...").focused($fieldIsFocused)
    }
  }
}

struct AddReviewView_Previews: PreviewProvider {
  static var previews: some View {
    AddReviewView(locationData: Location.mock)
  }
}
