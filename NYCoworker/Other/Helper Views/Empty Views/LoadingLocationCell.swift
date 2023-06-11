//
//  LoadingLocationCell.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/2/23.
//

import SwiftUI
import Shimmer

struct LoadingLocationCell: View {
  var type: CellType?
  var body: some View {
    switch type {
    case .none:
      singleCell()
    case .some(let wrapped):
      if wrapped == .list {
        listCells()
      }
      else {
        singleCell()
      }
    }
  }
}

extension LoadingLocationCell { // MARK: - View components
  @ViewBuilder
  func listCells() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      ZStack(alignment: .topTrailing) {
        Image("load")
          .resizable()
          .scaledToFill()
          .frame(height: 150)
          .cornerRadius(10)
        
      }
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 3) {
          Text("data.locationName")
            .foregroundColor(Resources.Colors.customBlack)
            .font(Resources.Fonts.regular(withSize: 20))
            .multilineTextAlignment(.leading)
          Text("data.locationAddress")
            .foregroundColor(Resources.Colors.darkGrey)
            .font(Resources.Fonts.regular(withSize: 13))
        }
        Spacer()
        Text(" mi")
          .foregroundColor(Resources.Colors.darkGrey)
          .font(Resources.Fonts.regular(withSize: 15))
      }
    }
    .redacted(reason: .placeholder)
    .shimmering(active: true, duration: 1.5, bounce: false)
  }
  
  @ViewBuilder
  func singleCell() -> some View {
    VStack(alignment: .leading, spacing: 3) {
      ZStack(alignment: .topTrailing) {
        Image("sample")
          .resizable()
          .scaledToFill()
          .frame(width: 180, height: 100)
          .cornerRadius(15)
        Button {
          print("Button tapped")
        } label: {
          Image("add")
            .resizable()
            .foregroundColor(Resources.Colors.customBlack)
            .frame(width: 15, height: 15)
            .padding(5)
            .background(Color.white)
            .cornerRadius(15)
            .offset(x: -6, y: 6)
        }
        
      }
      
      HStack(spacing: 3) {
        ForEach(0..<2) { title in
          NYCBadgeView(badgeType: .withWord, title: "title")
        }
      }
      
      Text("Name")
        .foregroundColor(Resources.Colors.customBlack)
        .font(Resources.Fonts.regular(withSize: 13))
        .lineLimit(0)
      
      HStack(spacing: 4) {
        Text("2 mi ·")
          .foregroundColor(Resources.Colors.darkGrey)
          .font(Resources.Fonts.regular(withSize: 12))
        RatingDotsView(number: 1)
      }
    }
    .frame(width: 180)
    .redacted(reason: .placeholder)
    .shimmering(active: true, duration: 1.5, bounce: false)
  }
}

extension LoadingLocationCell {
  enum CellType {
    case single
    case list
  }
}

struct LoadingLocationCell_Previews: PreviewProvider {
  static var previews: some View {
    LoadingLocationCell(type: .list)
  }
}
