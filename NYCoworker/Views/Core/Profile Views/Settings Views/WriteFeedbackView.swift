//
//  WriteFeedbackView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/20/23.
//

import SwiftUI

struct WriteFeedbackView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var message: String = ""
    let characterLimit = 300
    @State var showLoading = false
    @FocusState private var fieldIsFocused: Bool
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Share feedback")
                            .foregroundColor(Resources.Colors.customBlack)
                            .font(Resources.Fonts.bold(withSize: 24))
                        Text("Your opinion and ideas are very valuable for us")
                            .foregroundColor(Resources.Colors.darkGrey)
                            .font(Resources.Fonts.regular(withSize: 17))
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.leading, 16)
                
                VStack() {
                    HStack(spacing: 8) {
                        withAnimation(.easeInOut) {
                            TextField("", text: $message, axis: .vertical)
                                .focused($fieldIsFocused)
                                .onChange(of: message) { newValue in
                                    if newValue.count > characterLimit {
                                        message = String(newValue.prefix(characterLimit))
                                    }
                                }
                                .placeholder(when: message.isEmpty) {
                                    Text("How we can improve NYCoworker for you?")
                                        .foregroundColor(Resources.Colors.darkGrey)
                                }
                                .lineLimit(...7)
                        }
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 12)
                    .background(Resources.Colors.customGrey)
                    .cornerRadius(10)
                    .padding(.top, 15)
                    
                    HStack {
                        Text("\(characterLimit - message.count) characters left")
                            .foregroundColor(message.count == characterLimit ? Resources.Colors.actionRed : Resources.Colors.darkGrey)
                            .font(Resources.Fonts.regular(withSize: 14))
                        Spacer()
                        Button {
                            message = ""
                        } label: {
                            Text("Clear")
                                .foregroundColor(Resources.Colors.darkGrey)
                                .font(Resources.Fonts.regular(withSize: 14))
                        }

                    }
                }
                .padding([.leading,.trailing], 16)
                
            }
            .scrollDisabled(true)
            .onTapGesture {
                fieldIsFocused = false
            }
            .safeAreaInset(edge: .bottom, content: {
                Button {
                    
                } label: {
                    Text("Submit")
                }
                .buttonStyle(NYCActionButtonStyle(showLoader: $showLoading))
                .padding([.leading,.trailing], 16)
                .padding(.bottom, 15)
            })
            .toolbarBackground(.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.close) {
                        makeDismiss()
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

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
