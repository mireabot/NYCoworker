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

struct LogoutView: View {
    @AppStorage("userSigned") var userLogged: Bool = false
    @Environment(\.dismiss) var makeDismiss
    @State var isLoading = false
    @State var errorMessage = ""
    @State var showError = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NYCBottomSheetHeader(title: "Are you sure you want to delete account?").padding(.top, 15)
                VStack(alignment: .center, spacing: 10) {
                    NYCActionButton(action: {
                        withAnimation(.spring()) {
                            deleteUser()
                        }
                    }, text: "Delete", buttonStyle: .system)
                    
                    NYCActionButton(action: {
                        makeDismiss()
                    }, text: "Never mind", buttonStyle: .secondarySystem)

                }
                .frame(maxWidth: .infinity)
                .padding([.leading,.trailing], 16)
                .padding(.top, 10)
            }
        }
        .overlay {
            LoadingBottomView(show: $isLoading)
        }
        .alert(errorMessage, isPresented: $showError) {
        }
    }
    
    func deleteUser() {
        isLoading = true
        Task {
            do {
                guard let userID = Auth.auth().currentUser?.uid else { return }
                let ref = Storage.storage().reference().child("UserImages").child(userID)
                try await ref.delete()
                
                try await Firestore.firestore().collection("User").document(userID).delete()
                try await Auth.auth().currentUser?.delete()
                userLogged = false
            }
            catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            isLoading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
