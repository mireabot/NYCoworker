//
//  NYCSegmentControl.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/16/23.
//

import SwiftUI

struct NYCSegmentControl: View {
  @State var selectedSegment = 1
  @Binding var title: String
  var body: some View {
    HStack(spacing: 20) {
      Button {
        withAnimation(.spring()) {
          selectedSegment = 1
          title = "Positive"
        }
      } label: {
        Text("Positive")
          .foregroundColor(selectedSegment == 1 ? Resources.Colors.actionGreen : Resources.Colors.darkGrey)
          .font(Resources.Fonts.medium(withSize: 17))
          .padding(.vertical, 5)
          .padding(.horizontal, 10)
          .background(selectedSegment == 1 ? Color.white : Resources.Colors.customGrey)
          .clipShape(Capsule())
      }
      
      Button {
        withAnimation(.spring()) {
          selectedSegment = 2
          title = "Negative"
        }
      } label: {
        Text("Negative")
          .foregroundColor(selectedSegment == 2 ? Resources.Colors.actionRed : Resources.Colors.darkGrey)
          .font(Resources.Fonts.medium(withSize: 17))
          .padding(.vertical, 5)
          .padding(.horizontal, 10)
          .background(selectedSegment == 2 ? Color.white : Resources.Colors.customGrey)
          .clipShape(Capsule())
      }

    }
    .padding(.vertical, 5)
    .padding(.horizontal, 5)
    .background(Resources.Colors.customGrey)
    .clipShape(Capsule())
  }
}

//struct NYCSegmentControl_Previews: PreviewProvider {
//  static var previews: some View {
//    NYCSegmentControl()
//  }
//}
