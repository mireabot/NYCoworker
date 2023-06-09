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
    VStack(alignment: .leading, spacing: 0) {
      Text(updatesData.text)
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 17))
        .lineSpacing(5)
        .frame(height: 70, alignment: .top)
        .multilineTextAlignment(.leading)
        .allowsTightening(true)
      
      Button {
        buttonAction()
      } label: {
        Text("Learn more")
          .foregroundColor(Resources.Colors.darkGrey)
          .font(Resources.Fonts.medium(withSize: 17))
          .underline(true, pattern: .solid, color: Resources.Colors.darkGrey)
      }
      .opacity(updatesData.url.isEmpty ? 0 : 1)
    }
    .fixedSize(horizontal: false, vertical: true)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(10)
    .padding(.trailing, 25)
    .background(Resources.Colors.customGrey)
    .cornerRadius(10)
  }
}

/*
struct InstructionCell_Previews: PreviewProvider {
  static var previews: some View {
    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
      ForEach(0..<5, id: \.self) { item in
        InstructionCell(text: "Wi-Fi 12345")
      }
    }
    .padding([.leading,.trailing], 16)
  }
}
*/
