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
    @State var nameText: String = ""
    @State var occupationText: String = ""
    enum Field: Hashable {
        case nameField
        case occupationField
    }
    @FocusState private var focusedField: Field?
    @State private var isLoading = false
    @State var showAlert = false
    @EnvironmentObject var userService : UserService
    @AppStorage("UserID") var userId : String = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                WebImage(url: userService.user.avatarURL).placeholder {
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
        .popup(isPresented: $showAlert) {
            NYCAlertNotificationView(alertStyle: .dataUploaded)
        } customize: {
            $0
                .isOpaque(true)
                .autohideIn(1.5)
                .type(.floater())
                .position(.top)
                .animation(.spring(response: 0.4, blendDuration: 0.2))
        }
        .scrollDisabled(true)
        .onTapGesture {
            focusedField = nil
        }
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
            .disabled(nameText == userService.user.name || nameText.isEmpty)
            .buttonStyle(NYCActionButtonStyle(showLoader: $isLoading))
            .padding(.bottom, 15)
            .padding([.leading,.trailing], 16)
            
        })
        .onAppear {
            nameText = userService.user.name
            occupationText = userService.user.occupation
        }
    }
    
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

//struct ManageAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageAccountView()
//    }
//}