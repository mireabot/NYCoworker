//
//  AddReviewView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/21/23.
//

import SwiftUI
import PopupView

struct AddReviewView: View {
    @Environment(\.dismiss) var makeDismiss
    @State var visitDate = Date()
    @State var reviewText = ""
    @State var tfHeight: CGFloat = 30
    @State var showDate = false
    enum Field: Hashable {
        case reviewField
    }
    @FocusState private var focusedField: Field?
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                locationCard()
                    .padding([.leading,.trailing], 16)
                    .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 20) {
                    reviewRate()
                    
                    calendarView()
                    
                    reviewInfo()
                        
                }
                .padding([.leading,.trailing], 16)
                .padding(.top, 10)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Submit")
                }
                .disabled(reviewText == "" ? true : false)
                .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
                .padding(.bottom, 10)
                .padding([.leading,.trailing], 16)
                

            }
            .navigationBarBackButtonHidden()
            .toolbarBackground(.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Add review")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 17))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        makeDismiss()
                    } label: {
                        Resources.Images.Navigation.close
                            .foregroundColor(Resources.Colors.customBlack)
                    }
                }
            }
            .onTapGesture {
                focusedField = nil
            }
        }
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
    func reviewRate() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Overall feelings")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 15))
            HStack(spacing: 5) {
                NYCRateBadge(badgeType: .expanded, reviewType: .postive)
                NYCRateBadge(badgeType: .expanded, reviewType: .negative)
            }
        }
    }
    
    @ViewBuilder
    func calendarView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Date of visit")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 15))
            
            Text(visitDate.toString("MMMM d"))
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 20))
                .onTapGesture {
                    showDate.toggle()
                }
        }
    }
    
    @ViewBuilder
    func reviewInfo() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Describe your experience")
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.regular(withSize: 15))
            
            NYCResizableTextField(text: $reviewText, height: $tfHeight, placeholderText: "Write your thoughts").frame(height: tfHeight < 160 ? self.tfHeight : 160).cornerRadius(12)
                .focused($focusedField, equals: .reviewField)
        }
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView()
    }
}
