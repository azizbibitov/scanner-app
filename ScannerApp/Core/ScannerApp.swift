//
//  ScannerApp.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 28.08.2024.
//

import SwiftUI

@main
struct ScannerApp: App {

    @StateObject var coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            StartScreenView()
                .environmentObject(coordinator)
        }
    }
}
