//
//  Coordinator.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import Foundation
import SwiftUI

enum Page {
    case camera
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    @ViewBuilder
    func view(for page: Page) -> some View {
        switch page {
        case .camera:
            CameraScreenView()
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
