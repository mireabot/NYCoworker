//
//  NYCSectionHeader.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/2/23.
//

import SwiftUI

struct NYCSectionHeader: View {
    var title: String
    var isExpandButton: Bool
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 22))
            Image("chevron-right")
                .resizable()
                .foregroundColor(Resources.Colors.customBlack)
                .frame(width: 15, height: 15)
                .padding(5)
                .background(Resources.Colors.customGrey)
                .cornerRadius(15)
                .opacity(isExpandButton ? 1 : 0)
        }
    }
}

//struct NYCSectionHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCSectionHeader(title: "Default")
//    }
//}
