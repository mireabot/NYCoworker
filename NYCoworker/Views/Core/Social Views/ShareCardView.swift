//
//  ShareCardView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/4/23.
//

import SwiftUI

struct ShareCardView: View {
    var buttonAction: () -> Void
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: -12) {
                    ForEach(0..<4){ index in
                        Image("p\(index)")
                    }
                }
                .padding(.leading, 12)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Meet new people anywhere you work")
                        .foregroundColor(.white)
                        .font(Resources.Fonts.bold(withSize: 17))
                    Text("Coming soon")
                        .foregroundColor(.white)
                        .font(Resources.Fonts.regular(withSize: 15))
                }
                
                Button {
                    buttonAction()
                } label: {
                    HStack(spacing: 3) {
                        Text("Share app")
                            .foregroundColor(Resources.Colors.primary)
                            .font(Resources.Fonts.bold(withSize: 13))
                        Resources.Images.Navigation.share
                            .resizable().frame(width: 18, height: 18)
                            .foregroundColor(Resources.Colors.primary)
                    }
                    .padding(5)
                    .background(.white)
                    .cornerRadius(5)
                }

            }
            .padding(15)
            Spacer()
        }
        .background(Resources.Colors.primary)
        .cornerRadius(15)
        .padding([.leading,.trailing], 16)
        .padding(.top, 20)
    }
}

//struct ShareCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareCardView()
//    }
//}
