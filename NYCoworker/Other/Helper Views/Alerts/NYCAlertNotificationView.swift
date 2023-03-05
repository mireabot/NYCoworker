//
//  NYCAlertView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/18/23.
//

import SwiftUI

struct NYCAlertNotificationView: View {
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
//        NYCAlertNotificationView(title: "Added to favorites", alertStyle: .small)
        NYCAlertView(type: .notification, action: {})
    }
}

struct NYCAlertView: View {
    let type: AlertType
    var action: (()->Void)
    enum AlertType {
        case notification
        case geoposition
        
        var title: String {
            switch self {
            case .notification:
                return "Notifications are off"
            case .geoposition:
                return "Geoposition is off"
            }
        }
        var subtitle: String {
            switch self {
            case .notification:
                return "You can turn on notification later in settings"
            case .geoposition:
                return "You can turn on geoposition later in settings"
            }
        }
    }
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(type.title)
                .foregroundColor(Resources.Colors.customBlack)
                .font(Resources.Fonts.bold(withSize: 20))
            Text(type.subtitle)
                .foregroundColor(Resources.Colors.darkGrey)
                .font(Resources.Fonts.regular(withSize: 17))
                .multilineTextAlignment(.center)
            
            Button {
                action()
            } label: {
                Text("Got it")
            }
            .buttonStyle(NYCActionButtonStyle())
            .padding([.leading,.trailing], 40)
            .padding(.top, 10)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding([.leading,.trailing], 16)
    }
}
