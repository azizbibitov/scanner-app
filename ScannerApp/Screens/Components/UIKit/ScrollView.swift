//
//  ScrollView.swift
//  BaseApp
//
//  Created by Shirin on 3/24/23.
//

import UIKit
import EasyPeasy

class ScrollView: UIScrollView {

    var contentStack: UIStackView!

    init(spacing: CGFloat, edgeInsets: UIEdgeInsets = .zero, keyboardDismissMode: KeyboardDismissMode = .onDrag){
        super.init(frame: .zero)

        self.keyboardDismissMode = keyboardDismissMode
        contentStack = UIStackView(axis: .horizontal,
                                   alignment: .fill,
                                   spacing: spacing,
                                   edgeInsets: edgeInsets)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(contentStack)
        contentStack.easy.layout([
            Edges()
        ])
    }
}
