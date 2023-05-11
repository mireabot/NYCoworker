//
//  ReportEditView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/8/23.
//

import SwiftUI
import PopupView

struct ReportEditView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var reportText = ""
    @State var tfHeight: CGFloat = 30
    @State var buttonLoader = false
    @Binding var showAlert : Bool
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    locationCard()
                    Spacer()
                }
                .padding(.top, 10)
                
                reportField()
                    .padding(.top, 20)
                
                Button {
                    self.buttonLoader = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.spring()) {
                            self.buttonLoader = false
                            makeDismiss()
                            showAlert = true
                        }
                    }
                } label: {
                    Text("Submit")
                }
                .buttonStyle(NYCActionButtonStyle(showLoader: $buttonLoader))
                .padding(.top, 10)
                .disabled(reportText == "")

            }
            .padding([.leading,.trailing], 16)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Suggest edit")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 17))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            makeDismiss()
                        }
                    } label: {
                        Resources.Images.Navigation.close
                            .foregroundColor(Resources.Colors.customBlack)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.white, for: .navigationBar)
    }
    
    @ViewBuilder
    func locationCard() -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image("load")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            VStack(alignment: .leading, spacing: 2) {
                Text("Public Hotel")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.regular(withSize: 15))
                Text("691 Eight Avenue, New York, NY 10036")
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 13))
            }
        }
    }
    
    @ViewBuilder
    func reportField() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Enter your suggestions")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 15))
            
            NYCResizableTextField(text: $reportText, height: $tfHeight, placeholderText: "Write your thoughts").frame(height: tfHeight < 160 ? self.tfHeight : 160).cornerRadius(12)
        }
    }
}

//struct ReportEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportEditView()
//    }
//}
