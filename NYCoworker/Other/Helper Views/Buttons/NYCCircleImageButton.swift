//
//  NYCCircleImageButton.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/1/23.
//

import SwiftUI

struct NYCCircleImageButton: View {
  enum ColorType {
    case black
    case green
  }
  var size: CGFloat
  var image: Image
  var color: ColorType? = .green
  var showBadge: Bool?
  var action: () -> Void
  var body: some View {
    Button {
      action()
    } label: {
      image
        .resizable()
        .frame(width: size, height: size)
        .foregroundColor(color == .green ? Resources.Colors.primary : Resources.Colors.customBlack)
        .padding(6)
        .background(Resources.Colors.customGrey)
        .cornerRadius(size)
        .overlay(alignment: .topTrailing) {
          Circle()
            .fill(Resources.Colors.primary)
            .frame(width: 10, height: 10)
            .offset(x: 0, y: -2)
            .opacity(showBadge ?? false ? 1 : 0)
        }
    }
  }
}

struct NYCCircleImageButton_Previews: PreviewProvider {
    static var previews: some View {
      NYCCircleImageButton(size: 24, image: Resources.Images.Navigation.arrowBack, showBadge: true) {
        
      }
    }
}
