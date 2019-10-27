//
//  PokemonList.swift
//  PokeMaster
//
//  Created by yl on 2019/10/18.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    
    @EnvironmentObject var store: Store
    
    var body: some View {
            ScrollView{
                ForEach(store.appState.pokemonList.allPokemonsByID){pokemon in
                    PokemonInfoRow(model: pokemon, expanded: false)
                }
            }
//            .overlay(VStack{
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom))
                
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
