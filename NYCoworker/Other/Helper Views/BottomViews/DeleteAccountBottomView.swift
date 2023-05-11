//
//  LogoutView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

struct DeleteAccountBottomView: View {
  @AppStorage("userSigned") var userLogged: Bool = false
  @State var isLoading = false
  @State var errorMessage = ""
  @State var showError = false
  @Binding var isVisible: Bool
  var body: some View {
    VStack {
      NYCBottomSheetHeader(title: "Delete account?").padding(.top, 15)
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: 10) {
          Text("Are you sure you want to delete account?")
            .multilineTextAlignment(.leading)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.bold(withSize: 18))
          Text("We will delete your account and all related information from out cloud.")
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.regular(withSize: 15))
            .multilineTextAlignment(.leading)
        }
        .padding(.top, 5)
        
        VStack(alignment: .center, spacing: 10) {
          NYCActionButton(action: {
            isVisible = false
          }, text: "Never mind", buttonStyle: .secondarySystem)
          
          NYCActionButton(action: {
            withAnimation(.spring()) {
              deleteUser()
            }
          }, text: "Delete", buttonStyle: .system)
        }
        .padding(.top, 10)
      }
      .padding([.leading,.trailing], 16)
      .padding(.bottom, 40)
      .frame(maxWidth: .infinity)
    }
    .background(Color.white)
    .cornerRadius(16, corners: [.topLeft, .topRight])
    .overlay {
      LoadingBottomView(show: $isLoading)
    }
  }
  
  func deleteUser() {
    isLoading = true
    //        Task {
    //            do {
    //                guard let userID = Auth.auth().currentUser?.uid else { return }
    //                let ref = Storage.storage().reference().child("UserImages").child(userID)
    //                try await ref.delete()
    //
    //                try await Firestore.firestore().collection("User").document(userID).delete()
    //                try await Auth.auth().currentUser?.delete()
    //                userLogged = false
    //            }
    //            catch {
    //                await setError(error)
    //            }
    //        }
  }
  
  func setError(_ error: Error) async {
    await MainActor.run(body: {
      isLoading = false
      errorMessage = error.localizedDescription
      showError.toggle()
    })
  }
}
