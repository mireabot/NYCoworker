//
//  UserRegistrationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

class UserRegistrationModel: ObservableObject {
    @Published var name = ""
    @Published var occupation = ""
    @Published var gender = ""
    @Published var accountType = ""
    @Published var profileImage: Data?
    
    @AppStorage("UserID") var userId : String = ""
    @AppStorage("UserMail") var userMail : String = ""
    @AppStorage("UserPass") var userPass : String = ""
    @AppStorage("userSigned") var userLogged: Bool = false
    
    func createUser(mail: String, pass: String,completion: @escaping () -> Void) {
        Task {
            do {
                try await Auth.auth().createUser(withEmail: "\(mail)@nycoworker.user", password: pass)
                guard let userID = Auth.auth().currentUser?.uid else { return }
                guard let imageData = profileImage else { return }
                let storageRef = Storage.storage().reference().child("UserImages").child(userID)
                let _ = try await storageRef.putDataAsync(imageData)
                
                let downloadURL = try await storageRef.downloadURL()
                
                let user = User(userID: userID, avatarURL: downloadURL, name: name, occupation: occupation, favoriteLocations: [])
                
                let _ = try Firestore.firestore().collection(Endpoints.users.rawValue).document(userID).setData(from: user,completion: {
                    error in
                    if error == nil {
                        print("Data was saved")
                        self.userId = userID
                        print("User id \(self.userId)")
                        completion()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.userMail = "\(mail)@nycoworker.user"
                            self.userPass = pass
                            self.userLogged = true
                        }
                    }
                })
            }
            catch {
                try await Auth.auth().currentUser?.delete()
                print(error.localizedDescription)
            }
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "0123456789QWERTYUIOPASDFGHJKLZXCVBNM"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
