//
//  WriteFeedbackView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/20/23.
//

import SwiftUI
import PopupView

struct WriteFeedbackView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  @State var message: String = ""
  @State var showLoading = false
  @FocusState private var fieldIsFocused: Bool
  @AppStorage("UserID") var userId : String = ""
  @StateObject var userService = UserService()
  @State private var showAlert = false
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        HStack {
          VStack(alignment: .leading, spacing: 5) {
            Text("Share feedback")
              .foregroundColor(Resources.Colors.customBlack)
              .font(Resources.Fonts.medium(withSize: 24))
            Text("Your opinion and ideas are very valuable for us")
              .foregroundColor(Resources.Colors.darkGrey)
              .font(Resources.Fonts.regular(withSize: 17))
              .multilineTextAlignment(.leading)
          }
          Spacer()
        }
        .padding(.top, 10)
        .padding(.leading, 16)
        
        NYCResizableTextField(message: $message, characterLimit: 1000, placeHolder: "How we can improve NYCoworker for you?")
          .focused($fieldIsFocused)
          .padding([.leading,.trailing], 16)
        
      }
      .onTapGesture {
        fieldIsFocused = false
      }
      .popup(isPresented: $showAlert) {
        NYCMiddleAlertView(alertType: .feedbackSubmitted) {
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
            DispatchQueue.main.async {
              message = ""
              router.nav?.popViewController(animated: true)
            }
          }
      }
      .scrollDisabled(true)
      .safeAreaInset(edge: .bottom, content: {
        Button {
          showLoading = true
          fieldIsFocused = false
          Task {
            await userService.createFeedback(withID: userId, withMessage: message, reportType: "", locationID: "", completion: {
              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showLoading = false
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
        .disabled(message.isEmpty)
        .buttonStyle(NYCActionButtonStyle(showLoader: $showLoading))
        .padding([.leading,.trailing], 16)
        .padding(.bottom, 10)
      })
      .toolbarBackground(.white, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NYCCircleImageButton(size: 18, image: Resources.Images.Navigation.arrowBack) {
            DispatchQueue.main.async {
              router.nav?.popViewController(animated: true)
            }
          }
        }
      }
    }
  }
}

struct WriteFeedbackView_Previews: PreviewProvider {
  static var previews: some View {
    WriteFeedbackView()
  }
}
