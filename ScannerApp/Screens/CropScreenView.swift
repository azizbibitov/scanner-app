//
//  CropScreenView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import SwiftUI

struct CropScreenView: View {
    var images: [UIImage] = (1...7).compactMap { UIImage(named: "images\($0)") }

    var body: some View {
        ZStack {
            VStack {
                HeaderView(title: "Crop")
                CarouselView(images: images)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CarouselView: View {
    let images: [UIImage]
    @State private var currentIndex = 0

    private let itemWidthFraction: CGFloat = 0.8
    private let opacityFactor: CGFloat = 0.8
    private let scaleFactor: CGFloat = 0.8

    var body: some View {
        GeometryReader { geometry in
            let itemWidth = geometry.size.width * itemWidthFraction
            let horizontalPadding = (geometry.size.width - itemWidth) / 2

            ZStack {
                ForEach(images.indices, id: \.self) { index in
                    CarouselItem(image: images[index],
                                 size: CGSize(width: itemWidth, height: geometry.size.height),
                                 isActive: index == currentIndex,
                                 opacityFactor: opacityFactor,
                                 scaleFactor: scaleFactor)
                        .offset(x: offset(for: index, itemWidth: itemWidth))
                        .zIndex(zIndex(for: index))
                }
            }
            .padding(.horizontal, horizontalPadding)
            .gesture(dragGesture)
        }
        .frame(height: 450)
    }

    private func offset(for index: Int, itemWidth: CGFloat) -> CGFloat {
        CGFloat(index - currentIndex) * (itemWidth - 10)
    }

    private func zIndex(for index: Int) -> Double {
        index == currentIndex ? 1 : 0
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onEnded { value in
                let threshold: CGFloat = 50
                if value.translation.width < -threshold && currentIndex < images.count - 1 {
                    withAnimation { currentIndex += 1 }
                } else if value.translation.width > threshold && currentIndex > 0 {
                    withAnimation { currentIndex -= 1 }
                }
            }
    }
}

struct CarouselItem: View {
    let image: UIImage
    let size: CGSize
    let isActive: Bool
    let opacityFactor: CGFloat
    let scaleFactor: CGFloat

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .cornerRadius(8)
            .opacity(isActive ? 1 : opacityFactor)
            .scaleEffect(isActive ? 1 : scaleFactor)
    }
}

#Preview(body: {
    CropScreenView()
})
