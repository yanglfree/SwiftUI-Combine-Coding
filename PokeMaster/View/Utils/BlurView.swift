//
//  BlurView.swift
//  PokeMaster
//
//  Created by yl on 2019/10/22.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style) {
//        print("Init")
        self.style = style
    }
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
//        print("makeUIView")
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return addBlurView(view: view)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
//        print("Update")
//        addBlurView(view: uiView)
    }
    
    func addBlurView(view: UIView) -> UIView{
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view

    }
}

extension View{
    func blurBackground(style: UIBlurEffect.Style) -> some View{
        ZStack{
            BlurView(style: style)
            self
        }
    }
}
