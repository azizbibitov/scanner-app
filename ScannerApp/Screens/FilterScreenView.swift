//
//  FilterScreenView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 11.09.2024.
//

import SwiftUI

struct FilterScreenView: SwiftUI.View {
//    @EnvironmentObject var coordinator: Coordinator
    var images: [UIImage] = (1...7).compactMap { UIImage(named: "images\($0)") }
    @StateObject var viewModel = CropScreenViewModel()

    var body: some SwiftUI.View {
        ZStack {
            VStack(spacing: 0) {
                HeaderView(title: "Filter")

                SwiftUI.ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 320, height: 450)
                                .cornerRadius(10)
                                .background(Color.white)
                        }
                    }
                    .padding((UIScreen.main.bounds.width - 320)/2)
                    .padding(.top, 10)
                }
                .frame(height: 450)

                Spacer()

                Button(action: {

                }) {
                    Text("NEXT")
                }
                .buttonStyle(GradientButtonStyle())
                .padding(.horizontal, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FilterScreenView()
}
