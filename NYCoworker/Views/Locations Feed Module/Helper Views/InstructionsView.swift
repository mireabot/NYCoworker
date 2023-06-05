//
//  InstructionsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/4/23.
//

import SwiftUI

struct InstructionsView: View {
  @Binding var firstTabPressed: Bool
  @Binding var secondTabPressed: Bool
  var locationData: Location
  var body: some View {
    ZStack {
      HStack(alignment: .center, spacing: 0) {
        Button {
          firstTabPressed.toggle()
        } label: {
          HStack(spacing: 10) {
            Resources.Images.Navigation.alert
              .resizable()
              .frame(width: 20, height: 20)
              .foregroundColor(Resources.Colors.primary)
            
            Text("New updates")
              .font(Resources.Fonts.regular(withSize: 15))
              .foregroundColor(Resources.Colors.darkGrey)
              .padding(.leading, -2)
            
            Resources.Images.Navigation.chevron
              .resizable()
              .frame(width: 20, height: 20)
              .foregroundColor(Resources.Colors.customBlack)
          }
          .frame(maxWidth: .infinity)
        }
        .disabled(locationData.locationUpdates.isEmpty)
        
        Button {
          secondTabPressed.toggle()
        } label: {
          HStack(spacing: 10) {
            Resources.Images.Tabs.socialTab
              .resizable()
              .frame(width: 20, height: 20)
              .foregroundColor(Resources.Colors.primary)
            
            Text("\(locationData.reviews) reviews")
              .font(Resources.Fonts.regular(withSize: 15))
              .foregroundColor(Resources.Colors.darkGrey)
              .padding(.leading, -2)
            
            Resources.Images.Navigation.chevron
              .resizable()
              .frame(width: 20, height: 20)
              .foregroundColor(Resources.Colors.customBlack)
          }
          .frame(maxWidth: .infinity)
        }
        .disabled(locationData.reviews == 0)
      }
      
      Rectangle()
        .fill(Resources.Colors.darkGrey)
        .frame(width: 1)
    }
    .padding(15)
    .background(Resources.Colors.customGrey)
    .cornerRadius(15)
    .fixedSize(horizontal: false, vertical: true)
  }
}

//struct InstructionsView_Previews: PreviewProvider {
//  static var previews: some View {
//    InstructionsView()
//  }
//}
