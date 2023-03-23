//
//  RatingDotsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/22/23.
//

import SwiftUI

struct RatingDotsView: View {
    var number: Int
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            ZStack(alignment: .leading) {
                HStack(spacing: 2) {
                    ForEach(0..<5) { _ in
                        Circle()
                            .fill(Resources.Colors.customGrey)
                            .frame(width: 5, height: 5)
                    }
                }
                
                HStack(spacing: 2) {
                    ForEach(0..<self.number) { _ in
                        Circle()
                            .fill(Resources.Colors.primary)
                            .frame(width: 5, height: 5)
                    }.id(number)
                }
            }
            
            Text("\(number)")
                .foregroundColor(Resources.Colors.primary)
                .font(Resources.Fonts.regular(withSize: 12))
        }
    }
}

struct RatingDotsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingDotsView(number: 1)
    }
}
