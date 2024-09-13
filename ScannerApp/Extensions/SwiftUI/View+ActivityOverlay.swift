//
//  View+ActivityOverlay.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 12.09.2024.
//

import SwiftUI

extension View {

    func activityOverlay(isShowing: Binding<Bool>) -> some View {
        modifier(ActivityOverlayModifier(isShowing: isShowing))
    }
}

struct ActivityOverlayModifier: ViewModifier {

    let isShowing: Binding<Bool>

    func body(content: Content) -> some View {
        view(content: content, isShowing: isShowing)
    }

    @ViewBuilder private func view(content: Content, isShowing: Binding<Bool>) -> some View {
        if isShowing.wrappedValue {
            content.overlay(
                VStack {
                    ActivityIndicatorView(isAnimating: .constant(true))
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.8))
                    .edgesIgnoringSafeArea(.all)
            )
        } else {
            content
        }
    }
}
