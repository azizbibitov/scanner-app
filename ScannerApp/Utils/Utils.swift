//
//  Utils.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 12.09.2024.
//

import UIKit

class Utils {

    static func applyBlackAndWhiteFilter(to inputImage: UIImage, intensity: Double) -> UIImage {
        guard let ciImage = CIImage(image: inputImage) else { return inputImage }

        let filter = CIFilter.colorControls()
        filter.inputImage = ciImage
        filter.saturation = Float(1.0 - intensity)

        // Get a CIContext
        let context = CIContext()

        // Create a CGImage from the CIImage
        guard let outputCIImage = filter.outputImage,
              let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {
            return inputImage
        }

        // Create a UIImage from the CGImage
        let outputUIImage = UIImage(cgImage: cgImage)

        return outputUIImage

    }

}
