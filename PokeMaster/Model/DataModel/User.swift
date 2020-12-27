//
//  User.swift
//  PokeMaster
//
//  Created by yl on 2020/12/27.
//  Copyright © 2020 Liang. All rights reserved.
//

import Foundation

struct User: Codable {
    var email: String
    
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
