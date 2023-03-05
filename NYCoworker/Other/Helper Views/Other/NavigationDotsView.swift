//
//  NavigationDotsView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 3/2/23.
//

import SwiftUI

struct NavigationDotsView: View {
    let index: Int
    @Binding var page: Int
    var body: some View {
        Circle()
            .fill(checkForPage())
            .frame(width: 8, height: 8)
        
    }
    
    func checkForPage() -> Color {
        if index == page {
            return Resources.Colors.primary
        }
        return Resources.Colors.customGrey
    }
}

struct NavigationDotsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDotsView(index: 0, page: .constant(1))
    }
}
