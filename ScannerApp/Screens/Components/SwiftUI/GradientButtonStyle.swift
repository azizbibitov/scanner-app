//
//  GradientButtonStyle.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 11.09.2024.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(
                LinearGradient(
                    colors: [Color.blueLightCustom, Color.blueDarkCustom],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color(hex: "DADCFF"), lineWidth: 3)
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
