//
//  InstructionsExpandedView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/5/23.
//

import SwiftUI
import PopupView

struct InstructionsExpandedView: View {
  @State private var showBrowser = false
  @State private var browserLink : URL = URL(string: "https://www.nycoworker.com/")!
  var locationData: Location
    var body: some View {
      VStack {
        GrabberView()
        VStack {
          NYCBottomSheetHeader(title: "Location Updates").paddingForHeader()
          ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
              ForEach(locationData.locationUpdates ?? [], id: \.self) { item in
                InstructionCell(updatesData: item) {
                  browserLink = URL(string: item.url)!
                  DispatchQueue.main.async {
                    showBrowser.toggle()
                  }
                }
              }
            }
            .padding([.leading,.trailing], 16)
          }
        }
        .background(Color.white)
        .cornerRadius(16, corners: [.topLeft,.topRight])
      }
      .popup(isPresented: $showBrowser, view: {
        SafariBottomView(url: browserLink)
        
      }, customize: {
        $0
          .type(.toast)
          .isOpaque(true)
          .backgroundColor(Color.black.opacity(0.3))
          .position(.bottom)
          .closeOnTap(false)
          .closeOnTapOutside(false)
          .dragToDismiss(true)
          .animation(.spring(response: 0.4, blendDuration: 0.2))
      })
    }
}

//struct InstructionsExpandedView_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructionsExpandedView()
//    }
//}
