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
  @State private var showTip = false
  @State var photoItem: PhotosPickerItem?
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      /// Header
      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text("Complete your profile")
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 22))
          Text("This information will help you to leave reviews, find coworkers in social radar and many more.")
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 17))
        }
        
        Spacer()
      }
      .padding([.leading,.trailing], 16)
      .padding(.top, 10)
      
      ZStack {
        if let profileImage, let image = UIImage(data: profileImage) {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .contentShape(Circle())
        }
        else {
          ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .bottomTrailing) {
              Image("emptyImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
              
              Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(4)
                .background(Resources.Colors.primary)
                .clipShape(Circle())
            }
            if showTip {
              Text("Don't forget about avatar")
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 13))
                .background(Resources.Colors.customGrey)
                .cornerRadius(5)
                .offset(x: 100)
                .transition(.move(edge: .trailing))
            }
          }.animation(.interpolatingSpring(stiffness: 210, damping: 20), value: showTip)
        }
      }
      .frame(width: 100, height: 100)
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
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
        showTip = true
      }
    }
    .onTapGesture {
      fieldIsFocused = false
    }
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
