//
//  ProfileSetup.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI
import PhotosUI

struct ProfileSetup: View {
    @EnvironmentObject var model: UserRegistrationModel
    @FocusState private var fieldIsFocused: Bool
    @State var profileImage: Data?
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            /// Header
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Complete your profile")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 22))
                    Text("This information will help us improve your app experience")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 17))
                }
                
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 10)
            
            ZStack {
                if let profileImage, let image = UIImage(data: profileImage) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                else {
                    Image("emptyImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 90, height: 90)
            .clipShape(Circle())
            .contentShape(Circle())
            .padding(.top, 10)
            .onTapGesture {
                showImagePicker.toggle()
            }
            
            /// Main section - Name, Occupation, Personality
            VStack(alignment: .leading) {
                NYCTextField(title: "Your name", placeholder: "Ex. Michael", text: $model.name).focused($fieldIsFocused)
                NYCTextField(title: "Describe occupation", placeholder: "Ex. Freelancer", text: $model.occupation).focused($fieldIsFocused)
            }
            .padding([.leading,.trailing], 16)
            .padding(.top, 30)
            
        }
        .onTapGesture {
            fieldIsFocused = false
        }
        .addTransition()
        .scrollDisabled(true)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue {
                Task {
                    do {
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
                        
                        await MainActor.run(body: {
                            profileImage = imageData
                            model.profileImage = profileImage
                        })
                    }
                    catch {
                        
                    }
                }
            }
        }
    }
}

struct ProfileSetup_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetup().environmentObject(UserRegistrationModel())
    }
}
