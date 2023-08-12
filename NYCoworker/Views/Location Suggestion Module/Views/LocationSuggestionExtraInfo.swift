//
//  LocationSuggestionExtraInfo.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 8/10/23.
//

import SwiftUI

struct LocationSuggestionExtraInfo: View {
  @EnvironmentObject var reviewService: ReviewService
  @FocusState private var fieldIsFocused: Bool
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .center, spacing: 25) {
        NYCResizableTextField(message: $reviewService.suggestionModel.userComment, characterLimit: 1000, placeHolder: "Any comments from your side...").focused($fieldIsFocused)
      }
      .padding(.top, 30)
    }
    .onTapGesture {
      fieldIsFocused = false
    }
    .scrollDisabled(true)
    .padding([.leading,.trailing], 16)
  }
}

struct LocationSuggestionExtraInfo_Previews: PreviewProvider {
  static var previews: some View {
    LocationSuggestionExtraInfo().environmentObject(ReviewService())
  }
}
