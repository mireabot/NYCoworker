//
//  NYCSocialCard.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/4/23.
//

import SwiftUI

struct NYCSocialCard: View {
    var data: NYCSocialCardModel
    var body: some View {
        HStack {
            data.image
            
            VStack(alignment: .leading, spacing: 1) {
                Text(data.title)
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.medium(withSize: 15))
                Text(data.text)
                    .foregroundColor(Resources.Colors.darkGrey)
                    .font(Resources.Fonts.regular(withSize: 13))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
        .padding(10)
        .background(Resources.Colors.customGrey)
        .cornerRadius(10)
    }
}

struct NYCSocialCardModel : Identifiable {
    var id: Int
    var image: Image
    var title: String
    var text: String
}

let socialData = [
    NYCSocialCardModel(id: 0, image: Resources.Images.Social.search, title: "Pick a spot", text: "Find a place where you want to work today from our hand-picked list"),
    NYCSocialCardModel(id: 1, image: Resources.Images.Social.go, title: "Head to location", text: "You can plan a route from spot details page using Apple or Google Maps - your choice first"),
    NYCSocialCardModel(id: 2, image: Resources.Images.Social.mark, title: "Mark yourself", text: "You can make yourself visible to other coworkers that you are in current location - or stay private"),
]
