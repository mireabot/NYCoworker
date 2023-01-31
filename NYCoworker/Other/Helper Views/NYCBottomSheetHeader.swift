//
//  NYCBottomSheetHeader.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/26/23.
//

import SwiftUI

struct NYCBottomSheetHeader: View {
    var title: String
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(Resources.Fonts.bold(withSize: 17))
            Divider()
        }
    }
}

struct NYCHeader: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(Resources.Fonts.bold(withSize: 22))
                .padding(.leading, 16)
            Spacer()
        }
    }
}
