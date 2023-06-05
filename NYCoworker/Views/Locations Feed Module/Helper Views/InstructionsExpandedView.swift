//
//  InstructionsExpandedView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/5/23.
//

import SwiftUI

struct InstructionsExpandedView: View {
  var locationData: Location
    var body: some View {
      VStack {
        GrabberView()
        VStack {
          NYCBottomSheetHeader(title: "Location Updates").paddingForHeader()
          ScrollView(.vertical, showsIndicators: false) {
              VStack {
                ForEach(locationData.locationUpdates,id: \.self) { item in
                      InstructionCell(text: item)
                  }
              }
              .padding([.leading,.trailing], 16)
              .padding(.top, 10)
          }
        }
        .background(Color.white)
        .cornerRadius(16, corners: [.topLeft,.topRight])
      }
    }
}

//struct InstructionsExpandedView_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructionsExpandedView()
//    }
//}
