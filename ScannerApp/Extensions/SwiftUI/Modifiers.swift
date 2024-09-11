//
//  Modifiers.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import SwiftUI

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .kerning(-0.3)
            .lineSpacing(4)
    }
}
