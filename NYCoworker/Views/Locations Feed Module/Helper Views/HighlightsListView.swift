//
//  InstructionsExpandedView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/5/23.
//

import SwiftUI

struct HighlightsListView: View {
  @State private var showBrowser = false
  @State var browserLink : URL = Resources.websiteURL
  var locationData: Location
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .center, spacing: 10) {
          LazyVStack(pinnedViews: [.sectionHeaders]) {
            ForEach(locationData.locationUpdates ?? [], id: \.self) { item in
              InstructionCell(updatesData: item) {
                DispatchQueue.main.async {
                  browserLink = URL(string: item.url)!
                  showBrowser.toggle()
                }
              }
            }
          }
        }
        .padding([.leading,.trailing], 16)
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar(content: {
        ToolbarItem(placement: .principal) {
          Text("Highlights")
            .font(Resources.Fonts.medium(withSize: 17))
        }
      })
      .sheet(isPresented: $showBrowser) {
        SafariView(url: $browserLink)
      }
    }
  }
}

struct InstructionsExpandedView_Previews: PreviewProvider {
  static var previews: some View {
    HighlightsListView(locationData: .mock)
  }
}
