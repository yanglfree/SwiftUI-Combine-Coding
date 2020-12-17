//
//  SearchView.swift
//  PokeMaster
//
//  Created by yl on 2020/12/17.
//  Copyright © 2020 Liang. All rights reserved.
//

import SwiftUI

struct SearchView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 30))
        searchBar.placeholder = "搜索宝可梦"
        return searchBar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
