//
//  SafariView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 6/3/23.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    @Binding var url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
      return
    }
}
