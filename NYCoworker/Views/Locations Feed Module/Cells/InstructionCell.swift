//
//  InstructionCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/5/23.
//

import SwiftUI

struct InstructionCell: View {
  var updatesData: LocationUpdates
  var buttonAction: () -> Void
  var body: some View {
    VStack {
      VStack {
        VStack(alignment: .leading, spacing: 5) {
          Text(updatesData.title)
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.medium(withSize: 20))
          Text(updatesData.text)
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 17))
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        if !updatesData.url.isEmpty {
          HStack {
            Button {
              buttonAction()
            } label: {
              HStack(spacing: 1) {
                Text("Learn more")
                  .font(Resources.Fonts.medium(withSize: 17))
                Resources.Images.Navigation.chevronRight
              }
              .foregroundColor(Resources.Colors.customBlack)
            }
          }
          .frame(maxWidth: .infinity, alignment: .trailing)
        }
      }
      .padding(15)
    }
    .overlay {
      RoundedRectangle(cornerRadius: 15)
        .stroke(Resources.Colors.lightGrey, lineWidth: 1)
    }
  }
}

/*
 struct InstructionCell_Previews: PreviewProvider {
 static var previews: some View {
 InstructionCell(updatesData: [LocationUpdates.mock], buttonAction: {})
 .padding([.leading,.trailing], 16)
 }
 }
 */
