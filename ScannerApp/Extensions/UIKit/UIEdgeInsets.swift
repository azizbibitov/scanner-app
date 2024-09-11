//
//  UIEdgeInsets.swift
//  tmchat
//
//  Created by Shirin on 3/9/23.
//

import UIKit

extension UIEdgeInsets {

    init(edges: CGFloat) {
        self.init(top: edges,
                  left: edges,
                  bottom: edges,
                  right: edges)
    }
    
    init(hEdges: CGFloat = 0, vEdges: CGFloat = 0) {
        self.init(top: vEdges,
                  left: hEdges,
                  bottom: vEdges,
                  right: hEdges)
    }
}
