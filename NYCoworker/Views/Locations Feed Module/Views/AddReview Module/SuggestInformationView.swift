//
//  SuggestInformationView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/26/23.
//

import SwiftUI
import PopupView

struct SuggestInformationView: View {
  var locationID: String?
  @Binding var isPresented: Bool
  @State var message = ""
  @State private var topic = ""
  @StateObject private var userService = UserService()
  @AppStorage("UserID") var userId : String = ""
  @FocusState private var fieldIsFocused: Bool
  @State private var isLoading = false
  @State private var showAlert = false
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
        
        NYCResizableTextField(message: $message, characterLimit: 500, placeHolder: "What others should know?")
          .padding([.leading,.trailing], 16)
          .focused($fieldIsFocused)
      }
      .popup(isPresented: $showAlert) {
        NYCMiddleAlertView(alertType: .suggestionSubmitted) {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
              message = ""
              topic = ""
              isPresented = false
            }
          }
      }
      .onTapGesture {
        fieldIsFocused = false
      }
      .scrollDisabled(true)
      .safeAreaInset(edge: .bottom, content: {
        Button {
          isLoading = true
          fieldIsFocused = false
          Task {
            await userService.createFeedback(withID: userId, withMessage: message, reportType: topic, locationID: locationID, completion: {
              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isLoading = false
                showAlert.toggle()
                AnalyticsManager.shared.log(.feedbackSubmitted)
              }
            }) { err in
              print(err.localizedDescription)
            }
          }
        } label: {
          Text("Submit")
        }
        .buttonStyle(NYCActionButtonStyle(showLoader: $isLoading))
        .disabled(message.isEmpty || topic.isEmpty)
        .padding([.leading,.trailing], 16)
        .padding(.bottom, 10)
        
      })
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 18, image: Resources.Images.Navigation.close) {
            isPresented = false
          }
        }
      }
    }
  }
}

struct SuggestInformationView_Previews: PreviewProvider {
  static var previews: some View {
    SuggestInformationView(locationID: "", isPresented: .constant(false))
  }
}
