//
//  PokemonList.swift
//  PokeMaster
//
//  Created by yl on 2019/10/18.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    var body: some View {
        //        List(PokemonViewModel.all){pokemon in
        //            PokemonInfoRow(model: pokemon, expanded: false)
        //        }
        
        NavigationView{
            ScrollView{
                ForEach(PokemonViewModel.all){pokemon in
                    PokemonInfoRow(model: pokemon, expanded: false)
                }
            }
//            .overlay(VStack{
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom))
                .navigationBarTitle("宝可梦列表")
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
