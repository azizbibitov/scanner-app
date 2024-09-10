//
//  CaptureButton.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import SwiftUI

struct CaptureButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(.white)
                .frame(width: 70, height: 70, alignment: .center)
                .overlay(
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blueLightCustom, Color.blueDarkCustom]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 59, height: 59, alignment: .center)
                )

        }
    }
}
