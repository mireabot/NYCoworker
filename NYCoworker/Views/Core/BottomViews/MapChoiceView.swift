//
//  MapChoiceView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI

struct MapChoiceView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NYCBottomSheetHeader(title: "Where you want to go?").padding(.top, 15)
                VStack(alignment: .center, spacing: 10) {
                    NYCActionButton(action: {
                        
                    }, text: "Apple Maps")
                    
                    NYCActionButton(action: {
                        
                    }, text: "Google Maps", buttonStyle: .secondary)
                }
                .frame(maxWidth: .infinity)
                .padding([.leading,.trailing], 16)
                .padding(.top, 10)
            }
            .onAppear {
                print(geometry.size.height)
            }
        }
    }
}

struct MapChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MapChoiceView()
    }
}
