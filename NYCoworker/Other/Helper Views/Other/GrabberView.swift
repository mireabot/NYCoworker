//
//  GrabberView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/19/23.
//

import SwiftUI

struct GrabberView: View {
    var body: some View {
      HStack {
        Spacer()
        Rectangle()
          .foregroundColor(Resources.Colors.customGrey)
          .frame(width: 50, height: 5)
          .cornerRadius(25)
        Spacer()
      }
    }
}

struct GrabberView_Previews: PreviewProvider {
    static var previews: some View {
        GrabberView()
    }
}
