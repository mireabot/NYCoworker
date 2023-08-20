//
//  LocationSuggestionBasicInfo.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/9/23.
//

import SwiftUI

struct LocationSuggestionBasicInfo: View {
  @EnvironmentObject var reviewStore: ReviewStore
  @FocusState private var fieldIsFocused: Bool
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .center, spacing: 25) {
        NYCTextField(title: "Location's name", placeholder: "Ex: Sweet Coffee", text: $reviewStore.suggestionModel.locationName).focused($fieldIsFocused)
        NYCTextField(title: "Location's address", placeholder: "Ex: 123 Main St", text: $reviewStore.suggestionModel.locationAddress).focused($fieldIsFocused)
        NYCTextField(title: "Location's amenities", placeholder: "Ex: Wi-Fi, Meeting room", text: $reviewStore.suggestionModel.locationAmenities).focused($fieldIsFocused)
      }
      .padding(.top, 30)
    }
    .onTapGesture {
      fieldIsFocused = false
    }
    .padding([.leading,.trailing], 16)
  }
}

struct LocationSuggestionBasicInfo_Previews: PreviewProvider {
  static var previews: some View {
    LocationSuggestionBasicInfo().environmentObject(ReviewStore())
  }
}
