//
//  Coordinator.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import Foundation
import SwiftUI

enum Page: Hashable {
    case camera
    case crop(images: [UIImage])
    case filter(images: [UIImage])
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    @ViewBuilder
    func view(for page: Page) -> some View {
        switch page {
        case .camera:
            CameraScreenView()
        case .crop(let images):
            CropScreenView(images: images)
        case .filter(images: let images):
            Text("")
        }
    }

    func navigateTo(page: Page) {
            path.append(page)
    }

    func navigateBack() {
        if path.count > 0 {
            path.removeLast()
        }
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func pop(last: Int = 1) {
        for _ in 0..<last {
            if path.count > 0 {
                path.removeLast()
            }
        }
    }
}
