//
//  NYCAlertView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/18/23.
//

import SwiftUI

struct NYCAlertView: View {
    var title : String
    enum AlertStyle {
        case small
    }
    var alertStyle: AlertStyle
    var body: some View {
        switch alertStyle {
        case .small:
            smallAlert
        }
    }
    
    var smallAlert: some View {
        HStack {
            HStack(alignment: .center, spacing: 5) {
                Image("favs")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.white)
                Text(title)
                    .foregroundColor(Color.white)
                    .font(Resources.Fonts.regular(withSize: 17))
            }
            Spacer()
        }
        .padding(10)
        .background(Resources.Colors.customBlack)
        .cornerRadius(5)
        .padding([.leading,.trailing], 16)
    }
}

struct NYCAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NYCAlertView(title: "Added to favorites", alertStyle: .small)
    }
}
