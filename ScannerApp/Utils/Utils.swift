//
//  Utils.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 12.09.2024.
//

import UIKit

class Utils {
    
    static func applyBlackAndWhiteFilter(to inputImage: UIImage, intensity: Double) async -> UIImage? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    guard let ciImage = CIImage(image: inputImage) else {
                        continuation.resume(returning: inputImage)
                        return
                    }
                    
                    let filter = CIFilter.colorControls()
                    filter.inputImage = ciImage
                    filter.saturation = Float(1.0 - intensity)
                    
                    let context = CIContext()
                    
                    guard let outputCIImage = filter.outputImage,
                          let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {
                        continuation.resume(returning: inputImage)
                        return
                    }
                    
                    let outputUIImage = UIImage(cgImage: cgImage)
                    continuation.resume(returning: outputUIImage)
                }
            }
        }
    }

    static func applyWhiteBlackFilter(to inputImage: UIImage, intensity: CGFloat) async -> UIImage {
        guard let ciImage = CIImage(image: inputImage) else { return inputImage }

        let context = CIContext(options: nil)
        guard let grayscaleFilter = CIFilter(name: "CIColorControls") else { return inputImage }
        grayscaleFilter.setValue(ciImage, forKey: kCIInputImageKey)
        grayscaleFilter.setValue(0.0, forKey: kCIInputSaturationKey)  // Convert to grayscale
        grayscaleFilter.setValue(0.0, forKey: kCIInputBrightnessKey)  // No change in brightness
        grayscaleFilter.setValue(1.1, forKey: kCIInputContrastKey)    // Slightly increase contrast

        guard let grayscaleImage = grayscaleFilter.outputImage else { return inputImage }
        guard let exposureFilter = CIFilter(name: "CIExposureAdjust") else { return inputImage }
        exposureFilter.setValue(grayscaleImage, forKey: kCIInputImageKey)
        exposureFilter.setValue(intensity, forKey: kCIInputEVKey)  // Adjust exposure for intensity

        guard let outputImage = exposureFilter.outputImage else { return inputImage }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return inputImage
    }

}
