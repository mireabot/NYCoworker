//
//  MaintenanceOverlay.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/15/23.
//

import SwiftUI
import Lottie
import UIKit

struct MaintenanceOverlayView: View {
    var body: some View {
        ZStack {
            VStack(spacing: -40) {
                LottieAnimationViewWrapper(animationName: "lf30_editor_6x0porxc.json")
                    .frame(width: 250, height: 250)
                VStack(alignment: .center, spacing: 5) {
                    Text("NYCoworker is currently in maintenance stage")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 20))
                        .multilineTextAlignment(.center)
                    
                    Text("Check back later please")
                        .foregroundColor(Resources.Colors.darkGrey)
                        .font(Resources.Fonts.regular(withSize: 15))
                        .multilineTextAlignment(.center)
                }
                .padding([.leading,.trailing], 16)
            }
        }
    }
}

struct MaintenanceOverlay_Previews: PreviewProvider {
    static var previews: some View {
        MaintenanceOverlayView()
    }
}

struct LottieAnimationViewWrapper: UIViewRepresentable {
    typealias UIViewType = UIView

    var animationName: String
    let animationView = LottieAnimationView(name: "makeup.json")

    func makeUIView(context: UIViewRepresentableContext<LottieAnimationViewWrapper>) -> UIViewType {
        return UIView()
    }

    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieAnimationViewWrapper>) {
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.play()

        uiView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: uiView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: uiView.centerYAnchor)
        ])
    }
}
