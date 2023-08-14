//
//  ManageAccountView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/11/23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import PopupView

struct AccountSettingsView: View {
  @EnvironmentObject var router: NYCNavigationViewsRouter
  var currentUser: User
  @State var nameText: String = ""
  @State var occupationText: String = ""
  @FocusState private var focusedField: Field?
  @State private var isLoading = false
  @State var showAlert = false
  @AppStorage("UserID") var userId : String = ""
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          WebImage(url: currentUser.avatarURL).placeholder {
            Image("emptyImage")
              .resizable()
          }
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 100, height: 100)
          .clipShape(Circle())
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        
        VStack(spacing: 20) {
          NYCTextField(title: "Your name", placeholder: "Your name", text: $nameText)
            .focused($focusedField, equals: .nameField)
          NYCTextField(title: "Your occupation", placeholder: "Your occupation", text: $occupationText)
            .focused($focusedField, equals: .occupationField)
        }.padding([.leading,.trailing], 16)
        
      }
      .scrollDisabled(true)
      .onTapGesture {
        focusedField = nil
      }
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            DispatchQueue.main.async {
              router.nav?.popViewController(animated: true)
            }
          } label: {
            Resources.Images.Navigation.arrowBack
              .foregroundColor(Resources.Colors.primary)
          }
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
          Text(Strings.Settings.manageAccount)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 17))
        }
      })
      .toolbarBackground(.white, for: .navigationBar)
      .safeAreaInset(edge: .bottom, content: {
        Button {
          self.isLoading = true
          Task {
            await updateUserData(with: userId, name: nameText, occupation: occupationText) {
              isLoading = false
              showAlert.toggle()
            }
          }
        } label: {
          Text("Save")
        }
        .disabled(nameText == currentUser.name || nameText.isEmpty)
        .buttonStyle(NYCActionButtonStyle(showLoader: $isLoading))
        .padding(.bottom, 15)
        .padding([.leading,.trailing], 16)
        
      })
      .popup(isPresented: $showAlert) {
        NYCMiddleAlertView(alertType: .accountUpdated) {
          showAlert.toggle()
        }
      } customize: {
        $0
          .isOpaque(true)
          .backgroundColor(Color.black.opacity(0.3))
          .closeOnTap(false)
          .closeOnTapOutside(false)
          .animation(.spring(response: 0.4, blendDuration: 0.2))
          .dismissCallback {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              router.nav?.popViewController(animated: true)
            }
          }
      }
      .onAppear {
        nameText = currentUser.name
        occupationText = currentUser.occupation
      }
    }
  }
}

//struct ManageAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageAccountView()
//    }
//}

extension AccountSettingsView { //MARK: - Firebase functions
  func updateUserData(with userID: String, name: String, occupation: String, completion: @escaping () -> Void) async {
    do {
      try await Firestore.firestore().collection(Endpoints.users.rawValue).document(userID).updateData([
        "name": name,
        "occupation": occupation
      ])
      
      await MainActor.run(body: {
        completion()
      })
    }
    catch {
      print(error.localizedDescription)
    }
  }
}

extension AccountSettingsView {
  enum Field: Hashable {
    case nameField
    case occupationField
  }
}
