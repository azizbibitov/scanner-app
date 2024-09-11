//
//  StartScreenView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 28.08.2024.
//

import SwiftUI

struct StartScreenView: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
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
                            coordinator.navigateTo(page: .camera)
                        }) {
                            Text("NEXT")
                        }
                        .buttonStyle(GradientButtonStyle())
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
            .navigationDestination(for: Page.self) { page in
                coordinator.view(for: page)
            }
        }
    }
}

#Preview {
    StartScreenView()
}
