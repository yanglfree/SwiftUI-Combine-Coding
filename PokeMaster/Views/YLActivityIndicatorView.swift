//
//  YLActivityIndicatorView.swift
//  PokeMaster
//
//  Created by yl on 2020/12/27.
//  Copyright © 2020 Liang. All rights reserved.
//

import Foundation
import SwiftUI

struct YLActivityIndicatorView: UIViewRepresentable {
        
    func makeUIView(context: Context) -> some UIView {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.backgroundColor = .yellow
        indicatorView.startAnimating()
        return indicatorView
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
