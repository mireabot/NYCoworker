//
//  LoadingBottomView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/23/23.
//

import SwiftUI

struct LoadingBottomView: View {
    var body: some View {
        ActionSheetView(bgColor: .white) {
            VStack {
                NYCLoadingSpinner()
                    .padding(.top, 30)
                
                Text("Hand tight")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.bold(withSize: 22))
                    .padding(.top, 30)
            }
        }
    }
}

struct LoadingBottomView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBottomView()
    }
}
