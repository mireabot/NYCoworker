//
//  InstructionCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/5/23.
//

import SwiftUI

struct InstructionCell: View {
  var text: String
  var body: some View {
    Text(text)
      .font(Resources.Fonts.regular(withSize: 17))
      .foregroundColor(Resources.Colors.customBlack)
      .padding(.leading, 16)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 20)
      .padding(.horizontal, 5)
      .background(Resources.Colors.customGrey)
      .cornerRadius(15)
  }
}

struct InstructionCell_Previews: PreviewProvider {
  static var previews: some View {
    InstructionCell(text: "12345")
  }
}
