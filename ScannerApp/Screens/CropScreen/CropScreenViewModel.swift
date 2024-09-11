//
//  CropScreenViewModel.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 11.09.2024.
//

import Foundation
import UIKit

class CropScreenViewModel: ObservableObject {

    var cropViews: [CropPickerView] = []
    var croppedImages: [UIImage] = []

    func cropImages(completion: @escaping ([UIImage]) -> Void) {
        let group = DispatchGroup()

        for cropView in cropViews {
            group.enter()
            cropView.crop { crop in
                if let image = crop.image {
                    self.croppedImages.append(image)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(self.croppedImages)
        }
    }

}
