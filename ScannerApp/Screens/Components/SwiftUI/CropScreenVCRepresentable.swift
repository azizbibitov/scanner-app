//
//  CropScreenVCRepresentable.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 10.09.2024.
//

import SwiftUI

struct CropScreenVCRepresentable: UIViewControllerRepresentable {

    let images: [UIImage]
    let viewModel: CropScreenViewModel

    // Creates and returns the CropScreenViewController
    func makeUIViewController(context: Context) -> CropScreenViewController {
        let vc = CropScreenViewController(images: images, viewModel: viewModel)
        return vc
    }

    // Updates the view controller (no updates needed in this case)
    func updateUIViewController(_ uiViewController: CropScreenViewController, context: Context) {
        // No need to update the view controller for now
    }
}
