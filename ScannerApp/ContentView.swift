//
//  ContentView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 28.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                GradientBackgroundWithCurve()
                    .frame(height: UIScreen.main.bounds.height * 0.42)
                Spacer()
                VStack {
                    Text("Portable application")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.blueLightCustom, Color.blueDarkCustom],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    Text("Take it with you everywhere!")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "6A79B7"))
                        .padding(.top, 5)

                    Spacer()

                    Button(action: {
                        // Handle button tap
                    }) {
                        Text("NEXT")
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
                    }
                    .padding(.horizontal, 50)

                    let link = "[Terms of Service](https://www.apple.com/legal/privacy)" + " | " + "[Privacy Policy](https://www.apple.com/legal/internet-services/terms/site.html)"
                    Text(.init(link))
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "374374"))
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        .tint(Color(hex: "374374"))
                }
                .padding()
            }


        }
        .edgesIgnoringSafeArea(.all)
    }
}

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
                    control: CGPoint(x: width*3/4, y: height*0.85)
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

#Preview {
    ContentView()
}
