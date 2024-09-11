//
//  GradientBackgroundWithCurve.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import SwiftUI

struct GradientBackgroundWithCurve: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
                path.addLine(to: CGPoint(x: width, y: height * 0.9))
                path.addQuadCurve(
                    to: CGPoint(x: width/2, y: height * 0.9),
                    control: CGPoint(x: width*3/4, y: height*0.86)
                )
                path.addQuadCurve(
                    to: CGPoint(x: 0, y: height * 0.9),
                    control: CGPoint(x: width*1/4, y: height * 0.95)
                )
                path.closeSubpath()
            }
            .fill(
                LinearGradient(
                    colors: [Color.blueLightCustom, Color.blueDarkCustom],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
        }
    }
}
