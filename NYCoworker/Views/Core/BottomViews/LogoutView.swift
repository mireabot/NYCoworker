//
//  LogoutView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/6/23.
//

import SwiftUI

struct LogoutView: View {
    @AppStorage("userSigned") var userLogged: Bool = false
    @Environment(\.dismiss) var makeDismiss
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NYCBottomSheetHeader(title: "Are you sure you want to log out?").padding(.top, 15)
                VStack(alignment: .center, spacing: 10) {
                    NYCActionButton(action: {
                        withAnimation(.spring()) {
                            userLogged = false
                        }
                    }, text: "Log out", buttonStyle: .system)
                    
                    Button {
                        makeDismiss()
                    } label: {
                        Text("Never mind")
                            .foregroundColor(Resources.Colors.darkGrey)
                            .font(Resources.Fonts.bold(withSize: 17))
                    }

                }
                .frame(maxWidth: .infinity)
                .padding([.leading,.trailing], 16)
                .padding(.top, 10)
            }
        }
        
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
