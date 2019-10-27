//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by yl on 2019/10/26.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation
import SwiftUI

struct PokemonRootView: View{
    @EnvironmentObject var store: Store
    
    var body: some View{
        NavigationView{
            if store.appState.pokemonList.pokemons == nil{
                Text("Loading...").onAppear {
                    self.store.dispatch(.loadPokemons)
                }
            }else{
                PokemonList().navigationBarTitle("宝可梦列表")
            }
        }
    }
    
}
