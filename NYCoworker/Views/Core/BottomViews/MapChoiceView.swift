//
//  MapChoiceView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/17/23.
//

import SwiftUI

struct MapChoiceView: View {
    var body: some View {
        ActionSheetView(bgColor: .white) {
            VStack {
                VStack(alignment: .center, spacing: 10) {
                    Text("Where you want to go?")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 17))
                    
                    NYCActionButton(action: {
                        
                    }, text: "Apple Maps")
                    
                    NYCActionButton(action: {
                        
                    }, text: "Google Maps", buttonStyle: .secondary)
                }
                .frame(maxWidth: .infinity)
                .padding([.leading,.trailing], 16)
            }
            .padding([.top,.bottom], 10)
        }
    }
}

struct MapChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MapChoiceView()
    }
}
