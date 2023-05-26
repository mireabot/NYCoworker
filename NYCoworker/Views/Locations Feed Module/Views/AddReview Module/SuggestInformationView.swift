//
//  SuggestInformationView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/26/23.
//

import SwiftUI

struct SuggestInformationView: View {
  @Environment(\.dismiss) var makeDismiss
  @State var message = ""
  @State private var topic = ""
  @FocusState private var fieldIsFocused: Bool
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        HStack {
          VStack(alignment: .leading, spacing: 5) {
            Text("Any suggestions to note?")
              .foregroundColor(Resources.Colors.customBlack)
              .font(Resources.Fonts.medium(withSize: 24))
            Text("Help the community get up to date information about our spots!")
              .foregroundColor(Resources.Colors.darkGrey)
              .font(Resources.Fonts.regular(withSize: 17))
              .multilineTextAlignment(.leading)
          }
          Spacer()
        }
        .padding(.top, 10)
        .padding(.leading, 16)
        
        NYCChipCollection(tags: ["General information", "Amenities", "Working hours", "Image content"], title: $topic)
          .padding(.leading, 12)
        
        Rectangle()
          .foregroundColor(Resources.Colors.customGrey)
          .frame(height: 1)
          .padding([.leading,.trailing], 16)
        
        NYCResizableTextField(message: $message, characterLimit: 150, placeHolder: "Write what you want")
          .padding([.leading,.trailing], 16)
          .focused($fieldIsFocused)
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
        .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
        .disabled(message.isEmpty || topic.isEmpty)
        .padding([.leading,.trailing], 16)
        .padding(.bottom, 10)

      })
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 18, image: Resources.Images.Navigation.close) {
            makeDismiss()
          }
        }
      }
    }
  }
}

struct SuggestInformationView_Previews: PreviewProvider {
  static var previews: some View {
    SuggestInformationView()
  }
}
