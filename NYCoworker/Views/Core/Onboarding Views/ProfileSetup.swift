//
//  ProfileSetup.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import SwiftUI

struct ProfileSetup: View {
    @State var nameTextFieldText = ""
    @State var occupationTextFieldText = ""
    @State var personType: String = "Student"
    @State var prepareToNavigate: Bool = false
    @Environment(\.dismiss) var makeDismiss
    
    enum Field: Hashable {
        case nameField
        case occupationField
    }
    @FocusState private var focusedField: Field?
    var body: some View {
        NavigationStack {
            VStack {
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
                .padding(.top, 30)
                
                /// Main section - Name, Occupation, Personality
                VStack(alignment: .leading) {
                    NYCFloatingTextField(title: "Your name", text: $nameTextFieldText)
                        .focused($focusedField, equals: .nameField)
                    NYCFloatingTextField(title: "Describe occupation", text: $occupationTextFieldText)
                        .focused($focusedField, equals: .occupationField)
                    
                    Text("Who are you?")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.regular(withSize: 17))
                        .padding(.leading, 16)
                        .padding(.top, 10)
                    
                    HStack {
                        VStack(alignment: .center, spacing: 5) {
                            Image("student")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Text("Student")
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.regular(withSize: 14))
                        }
                        .padding([.top,.bottom], 15)
                        .padding([.leading,.trailing], 25)
                        .background(personType == "Student" ? Color.white : Resources.Colors.customGrey)
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Resources.Colors.primary, lineWidth: personType == "Student" ? 1 : 0)
                        }
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5,dampingFraction: 0.6)) {
                                personType = "Student"
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 5) {
                            Image("employed")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Text("Employed")
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.regular(withSize: 14))
                        }
                        .padding([.top,.bottom], 15)
                        .padding([.leading,.trailing], 25)
                        .background(personType == "Employed" ? Color.white : Resources.Colors.customGrey)
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Resources.Colors.primary, lineWidth: personType == "Employed" ? 1 : 0)
                        }
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5,dampingFraction: 0.6)) {
                                personType = "Employed"
                            }
                        }
                        
                        Spacer()
                        VStack(alignment: .center, spacing: 5) {
                            Image("not-sure")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Text("Not sure")
                                .foregroundColor(Resources.Colors.customBlack)
                                .font(Resources.Fonts.regular(withSize: 14))
                        }
                        .padding([.top,.bottom], 15)
                        .padding([.leading,.trailing], 25)
                        .background(personType == "Not sure" ? Color.white : Resources.Colors.customGrey)
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Resources.Colors.primary, lineWidth: personType == "Not sure" ? 1 : 0)
                        }
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5,dampingFraction: 0.6)) {
                                personType = "Not sure"
                            }
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
                
                Spacer()
                
                /// Action button
                Button(action: {
                    makeAction()
                }, label: {
                    Text("Continue")
                        .frame(width: UIScreen.main.bounds.width - 16, height: 48)
                })
                    .padding(.bottom, 10)
                    .disabled(nameTextFieldText == "")
                    .buttonStyle(NYCActionButtonStyle())
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        makeDismiss()
                    } label: {
                        Resources.Images.Navigation.arrowBack
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Resources.Colors.customBlack)
                    }
                    
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationDestination(isPresented: $prepareToNavigate) {
                NotificationPermission()
            }
            .navigationBarBackButtonHidden()
            .onTapGesture {
                focusedField = nil
            }
        }
    }
    
    func makeAction() -> Void {
        if nameTextFieldText != "" {
            prepareToNavigate.toggle()
        }
        else {
            print("Err")
        }
    }
}

struct ProfileSetup_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetup()
    }
}
