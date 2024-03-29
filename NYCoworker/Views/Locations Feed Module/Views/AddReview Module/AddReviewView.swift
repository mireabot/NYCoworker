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
  @Binding var isPresented: Bool
  @State var visitDate = Date()
  @State var reviewText = ""
  @State var reviewType : Review.ReviewType = .pos
  @State var showDate = false
  @State private var showLoader = false
  @State private var showAlert = false
  @FocusState private var fieldIsFocused: Bool
  @State private var sheetContentHeight = CGFloat(0)
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
      .sheet(isPresented: $showDate, content: {
        CalendarBottomView(showDate: $showDate, date: $visitDate)
          .background {
            GeometryReader { proxy in
              Color.clear
                .task {
                  sheetContentHeight = proxy.size.height
                }
            }
          }
          .presentationDetents([.height(sheetContentHeight)])
          .presentationDragIndicator(.visible)
      })
      .popup(isPresented: $showAlert) {
        NYCMiddleAlertView(alertType: .reviewUnderReview) {
          withAnimation(.spring()) {
            showAlert.toggle()
          }
        }
      } customize: {
        $0
          .isOpaque(true)
          .backgroundColor(Color.black.opacity(0.3))
          .closeOnTap(false)
          .closeOnTapOutside(false)
          .animation(.spring(response: 0.4, blendDuration: 0.2))
          .dismissCallback {
            dismiss()
          }
      }
      .onTapGesture {
        fieldIsFocused = false
      }
      .safeAreaInset(edge: .bottom, content: {
        Button {
          submitReview()
          AnalyticsManager.shared.log(.reviewSubmitted(locationData.locationID))
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
            dismiss()
          }
        }
      }
    }
  }
}

struct AddReviewView_Previews: PreviewProvider {
  static var previews: some View {
    AddReviewView(isPresented: .constant(false), locationData: Location.mock)
  }
}

extension AddReviewView { //MARK: - View components
  
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
          DispatchQueue.main.async {
            showDate.toggle()
          }
        }
    }
  }
  
  @ViewBuilder
  func reviewInfo() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("How you can describe your visit?")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 15))
      
      NYCResizableTextField(message: $reviewText, characterLimit: 1000, placeHolder: "It was a good place...").focused($fieldIsFocused)
    }
  }
}

extension AddReviewView { //MARK: - Functions
  func dismiss() {
    DispatchQueue.main.async {
      reviewText = ""
      isPresented = false
    }
  }
  
  func submitReview() {
    showLoader = true
    Task {
      await ReviewService.shared.createReview(from:
                                                Review(locationID: locationData.locationID,
                                                       datePosted: Timestamp(date: Date()),
                                                       dateVisited: Timestamp(date: visitDate),
                                                       text: reviewText,
                                                       type: reviewType,
                                                       userName: Resources.userName,
                                                       userImage: Resources.userImageUrl,
                                                       isLive: false,
                                                       userToken: UserDefaults.standard.string(forKey: "FCMToken") ?? "")
                                              ,completion: { result in
        switch result {
        case .success:
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.spring()) {
              showLoader = false
              showAlert.toggle()
            }
            AnalyticsManager.shared.log(.reviewSubmitted(locationData.locationID))
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      })
    }
  }
}
