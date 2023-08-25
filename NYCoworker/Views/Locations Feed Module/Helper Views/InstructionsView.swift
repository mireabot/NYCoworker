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
    HStack {
      Button {
        firstTabPressed.toggle()
      } label: {
        HStack(alignment: .center) {
          VStack(alignment: .leading, spacing: 2) {
            Text("Spot Updates")
              .foregroundColor(Resources.Colors.customBlack)
              .font(Resources.Fonts.regular(withSize: 15))
            Text("\(locationData.locationUpdates?.count ?? 0)")
              .foregroundColor(Resources.Colors.customBlack)
              .font(Resources.Fonts.bold(withSize: 17))
          }
          .padding(.leading, 10)
          Spacer()
          Resources.Images.Navigation.alert
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(Resources.Colors.primary)
            .padding(.trailing, 10)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 5)
        .background(Resources.Colors.customGrey)
        .cornerRadius(15)
      }
      .buttonStyle(NYCButtonStyle())
      .disabled(locationData.locationUpdates?.isEmpty ?? true)

      Button {
        secondTabPressed.toggle()
      } label: {
        HStack(alignment: .center) {
          VStack(alignment: .leading, spacing: 2) {
            Text("Reviews")
              .foregroundColor(Resources.Colors.customBlack)
              .font(Resources.Fonts.regular(withSize: 15))
            Text("\(locationData.reviews)")
              .foregroundColor(Resources.Colors.customBlack)
              .font(Resources.Fonts.bold(withSize: 17))
          }
          .padding(.leading, 10)
          Spacer()
          Resources.Images.Tabs.socialTab
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(Resources.Colors.primary)
            .padding(.trailing, 10)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 5)
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
      }
      .buttonStyle(NYCButtonStyle())
      .disabled(locationData.reviews == 0)
    }
  }
}

struct InstructionsView_Previews: PreviewProvider {
  static var previews: some View {
    InstructionsView(firstTabPressed: .constant(false), secondTabPressed: .constant(false), locationData: .mock)
      .padding([.leading,.trailing],16)
  }
}
