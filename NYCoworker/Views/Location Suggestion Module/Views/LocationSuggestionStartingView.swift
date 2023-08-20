//
//  LocationSuggestionStartingView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/9/23.
//

import SwiftUI
import SwiftUIIntrospect
import Lottie

struct LocationSuggestionStartingView: View {
  @Binding var showView: Bool
  @StateObject var reviewStore = ReviewStore()
  @State private var showLoader = false
  @State var count = 1
  @AppStorage("UserID") var userId : String = ""
  var body: some View {
    NavigationView(content: {
      VStack {
        TabView(selection: $count) {
          AnyView(startView)
            .tag(1)
          
          LocationSuggestionBasicInfo()
            .environmentObject(reviewStore)
            .tag(2)
          
          LocationSuggestionExtraInfo()
            .environmentObject(reviewStore)
            .tag(3)
          
          AnyView(successView)
            .tag(4)
        }
        .safeAreaInset(edge: .bottom) {
          VStack(spacing: 15) {
            NYCSegmentProgressBar(value: count, maximum: 4)
            Button(action: {
              if count == 4 {
                showView = false
                AnalyticsManager.shared.log(.locationSuggestionWasSubmitted)
              }
              else if count == 3 {
                showLoader = true
                Task {
                  do {
                    await ReviewService.shared.sendLocationSuggestion(with:
                                                                        LocationSuggestionModel(
                                                                          locationName: reviewStore.suggestionModel.locationName,
                                                                          locationAddress: reviewStore.suggestionModel.locationAddress,
                                                                          locationAmenities: reviewStore.suggestionModel.locationAmenities,
                                                                          userID: userId,
                                                                          userComment: reviewStore.suggestionModel.userComment,
                                                                          userToken: UserDefaults.standard.string(forKey: "FCMToken") ?? "nil",
                                                                          createdAt: Date()),
                                                                      completion: { result in
                      switch result {
                      case .success:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          showLoader = false
                          count += 1
                        }
                      case .failure(let error):
                        print(error.localizedDescription)
                      }
                    })
                  }
                }
              }
              else {
                count += 1
              }
            }, label: {
              if count == 1 {
                Text("Get started")
              }
              else if count == 4 {
                Text("Done")
              }
              else {
                Text("Next")
              }
            })
            .buttonStyle(NYCActionButtonStyle(showLoader: $showLoader))
            .disabled(checkButton())
            .padding(.bottom, 15)
          }
          .padding([.leading,.trailing], 16)
        }
      }
      .animation(.linear, value: count)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NYCCircleImageButton(size: 20, image: Resources.Images.Navigation.close, action: {
            showView = false
          })
        }
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 20, image: Resources.Images.Navigation.arrowBack, action: {
            count -= 1
          })
          .opacity(count == 1 || count == 4 ? 0 : 1)
        }
        
        ToolbarItem(placement: .principal) {
          Text(setToolBarTitle())
            .font(Resources.Fonts.regular(withSize: 18))
            .foregroundColor(Resources.Colors.customBlack)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    })
  }
}

struct LocationSuggestionStartingView_Previews: PreviewProvider {
  static var previews: some View {
    LocationSuggestionStartingView(showView: .constant(false))
  }
}

extension LocationSuggestionStartingView {
  var startView: any View {
    ScrollView(.vertical, showsIndicators: false) {
      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text("Ready to share your work hub? We're All Ears!")
            .font(Resources.Fonts.medium(withSize: 28))
            .foregroundColor(Resources.Colors.customBlack)
          Text("Virtual High-Five! We want to share some good stuff")
            .font(Resources.Fonts.regular(withSize: 17))
            .foregroundColor(Resources.Colors.darkGrey)
        }
        Spacer()
      }
      
      VStack(alignment: .center, spacing: 20) {
        NYCIntroCard(type: .business)
        NYCIntroCard(type: .coworker)
      }
      .padding(.top, 60)
    }
    .scrollDisabled(true)
    .padding([.leading,.trailing], 16)
  }
  
  var successView: any View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: -40) {
        LottieAnimationViewWrapper(animationName: .constant("success.json"))
          .frame(width: 250, height: 250)
        VStack(alignment: .center, spacing: 5) {
          Text("Our team is reviewing submission now!")
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 20))
            .multilineTextAlignment(.center)
          
          Text("We will send you notification once submission is approved")
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 15))
            .multilineTextAlignment(.center)
        }
      }
      .padding(.top, 60)
    }
    .scrollDisabled(true)
    .padding([.leading,.trailing], 16)
  }
  
  func checkButton() -> Bool {
    if count == 2 && (reviewStore.suggestionModel.locationName.isEmpty || reviewStore.suggestionModel.locationAddress.isEmpty || reviewStore.suggestionModel.locationAmenities.isEmpty) {
      return true
    }
    return false
  }
  
  func setToolBarTitle() -> String {
    switch count {
    case 1: return ""
    case 2: return "Let’s start from basic information"
    case 3: return "Now share any special details"
    case 4: return "You are all set!"
    default: return ""
    }
  }
}
