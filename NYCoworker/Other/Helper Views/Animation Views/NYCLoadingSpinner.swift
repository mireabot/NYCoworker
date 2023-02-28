//
//  NYCLoadingSpinner.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/23/23.
//

import SwiftUI

struct NYCLoadingSpinner: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<NYCLoadingSpinner>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<NYCLoadingSpinner>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


//struct NYCLoadingSpinner_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCLoadingSpinner(isAnimating: <#Binding<Bool>#>, style: <#UIActivityIndicatorView.Style#>)
//    }
//}
//
