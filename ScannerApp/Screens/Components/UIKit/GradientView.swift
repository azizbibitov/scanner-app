//
//  GradientView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 10.09.2024.
//

import UIKit
import SwiftUI

class GradientView: UIView {

    private let gradient: CAGradientLayer = {
        let layer = CAGradientLayer()
        let leadingColor: UIColor = UIColor(Color.blueLightCustom)
        let trailingColor: UIColor = UIColor(Color.blueDarkCustom)
        layer.colors = [leadingColor.cgColor, trailingColor.cgColor]
        layer.locations = [0 , 1]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        return layer
    }()

    init() {
        super.init(frame: .zero)
        gradient.frame = frame
        layer.insertSublayer(gradient, at: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds

    }
}
