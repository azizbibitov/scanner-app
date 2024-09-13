//
//  ActivityIndicatorView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 12.09.2024.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {

    @Binding var isAnimating: Bool
    private(set) var style: UIActivityIndicatorView.Style = .gray

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
