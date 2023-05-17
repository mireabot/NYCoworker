//
//  AddReviewView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/21/23.
//

import SwiftUI
import PopupView
import SDWebImageSwiftUI

struct AddReviewView: View {
  @Environment(\.dismiss) var makeDismiss
  @State var visitDate = Date()
  @State var reviewText = ""
  @State var reviewTypeText = ""
  @State var showDate = false
  @FocusState private var fieldIsFocused: Bool
  let locationData: Location
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        reviewType()
          .padding(.top, 10)
        locationCard()
          .padding([.leading,.trailing], 16)
          .padding(.top, 10)
        
        VStack(alignment: .leading, spacing: 5) {
          calendarView()
          reviewInfo()
        }
        .padding([.leading,.trailing], 16)
        .padding(.top, 10)
      }
      .onTapGesture {
        fieldIsFocused = false
      }
      .scrollDisabled(true)
      .safeAreaInset(edge: .bottom, content: {
        Button {
          
        } label: {
          Text("Submit")
        }
        .disabled(reviewText == "" ? true : false)
        .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
        .padding(.bottom, 10)
        .padding([.leading,.trailing], 16)
      })
      .navigationBarBackButtonHidden()
      .toolbarBackground(.white, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCHeader(title: "How was it?")
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
  func reviewType() -> some View {
    NYCSegmentControl(title: $reviewTypeText)
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
        .frame(width: 60, height: 60)
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
  func reviewRate() -> some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("Overall feelings")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 15))
      HStack(spacing: 5) {
        NYCRateBadge(badgeType: .expanded, reviewType: .postive)
        NYCRateBadge(badgeType: .expanded, reviewType: .negative)
      }
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
      NYCResizableTextField(message: $reviewText, characterLimit: 300, placeHolder: "How you can describe your visit?").focused($fieldIsFocused)
    }
  }
}

struct AddReviewView_Previews: PreviewProvider {
  static var previews: some View {
    AddReviewView(locationData: Location.mock)
  }
}
