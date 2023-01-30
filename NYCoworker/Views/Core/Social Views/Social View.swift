//
//  Social View.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI

struct SocialView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar {
                NYCHeader(title: "Find coworkers")
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 10)
            }
        }
    }
}

struct Social_View_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
