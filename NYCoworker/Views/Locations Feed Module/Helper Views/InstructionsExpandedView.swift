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
  @State var browserLink : URL = Resources.websiteURL
  var locationData: Location
    var body: some View {
      VStack {
        NYCBottomSheetHeader(title: "Location Updates").paddingForHeader()
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .center, spacing: 10) {
            ForEach(locationData.locationUpdates ?? [], id: \.self) { item in
              InstructionCell(updatesData: item) {
                DispatchQueue.main.async {
                  browserLink = URL(string: item.url)!
                  showBrowser.toggle()
                }
              }
            }
          }
          .padding([.leading,.trailing], 16)
        }
      }
      .background(Color.white)
      .sheet(isPresented: $showBrowser) {
        SafariView(url: $browserLink)
      }
    }
}

//struct InstructionsExpandedView_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructionsExpandedView()
//    }
//}
