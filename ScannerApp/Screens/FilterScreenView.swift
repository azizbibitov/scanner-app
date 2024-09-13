//
//  FilterScreenView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 11.09.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterScreenView: View {

    @EnvironmentObject var coordinator: Coordinator

    @State var images: [UIImage] = (1...7).compactMap { UIImage(named: "images\($0)") }
    @State private var filterIntensity: Double = 0.0
    @State var isFiltered: Bool = false
    @State var appliedFilterIntensity: Double = 0.0

    var body: some View {
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
                                .grayscale(filterIntensity)
                        }
                    }
                    .padding((UIScreen.main.bounds.width - 320)/2)
                    .padding(.top, 10)
                }
                .frame(height: 450)

                Spacer()

                if let firstImage = images.first {
                    HStack(spacing: 80){
                        VStack {
                            Image(uiImage: firstImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isFiltered ? Color.gray : Color(hex: "63A1FF"), lineWidth: isFiltered ? 1 : 3)
                                )
                                .onTapGesture {
                                    isFiltered = false
                                    appliedFilterIntensity = filterIntensity
                                    filterIntensity = 0.0
                                }
                            Text("Original")
                                .foregroundStyle(Color(hex: "5661FF"))
                        }
                        VStack {
                            Image(uiImage: firstImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .grayscale(filterIntensity)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(!isFiltered ? Color.gray.opacity(0.3) : Color(hex: "63A1FF"), lineWidth: !isFiltered ? 1 : 3)
                                )
                                .onTapGesture {
                                    isFiltered = true
                                    filterIntensity = appliedFilterIntensity
                                }
                            Text("WB")
                                .foregroundStyle(Color(hex: "5661FF"))
                        }
                    }
                }

                if isFiltered {
                    Slider(value: $filterIntensity, in: 0...1)
                        .onChange(of: filterIntensity) { newValue in
                            if filterIntensity > 0 && !isFiltered {
                                isFiltered = true
                            }else if filterIntensity == 0.0 && isFiltered {
                                isFiltered = false
                            }
                            
                        }
                        .padding()
                }

                Button(action: {
                    Task {
                        await applyFiltersAndNavigate()
                    }
                }) {
                    Text("NEXT")
                }
                .buttonStyle(GradientButtonStyle())
                .padding(.horizontal, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func applyFiltersAndNavigate() async {
        let filteredImages = await withTaskGroup(of: (Int, UIImage?).self) { group in
            for (index, image) in images.enumerated() {
                group.addTask {
                    let filteredImage = await Utils.applyBlackAndWhiteFilter(to: image, intensity: filterIntensity)
                    return (index, filteredImage)
                }
            }

            var results = [(Int, UIImage?)]()
            for await result in group {
                results.append(result)
            }
            return results.sorted(by: { $0.0 < $1.0 }).compactMap { $0.1 }
        }

        await MainActor.run {
            coordinator.navigateTo(page: .export(images: filteredImages))
        }
    }

}

#Preview {
    FilterScreenView()
}
