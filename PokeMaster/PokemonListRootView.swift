//
//  PokemonListRootView.swift
//  PokeMaster
//
//  Created by yl on 2020/12/17.
//  Copyright © 2020 Liang. All rights reserved.
//

import SwiftUI

struct PokemonListRootView: View {
    var body: some View {
        NavigationView{
            PokemonList().navigationBarTitle("宝可梦列表")
        }
    }
}

struct PokemonListRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListRootView()
    }
}
