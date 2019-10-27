//
//  LoadPokemonRequest.swift
//  PokeMaster
//
//  Created by yl on 2019/10/26.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct LoadPokemonRequest {
    let id: Int
    static var all: AnyPublisher<[PokemonViewModel], AppError>{
        (1...30).map{
            LoadPokemonRequest(id: $0).publisher
        }.zipAll
    }
    
    func pokemonPublisher(_ id: Int) -> AnyPublisher<Pokemon, Error>{
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!)
            .map{ $0.data }
            .decode(type: Pokemon.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
    
    func speciesPublisher(_ pokemon: Pokemon) -> AnyPublisher<(Pokemon, PokemonSpecies), Error>{
        URLSession.shared.dataTaskPublisher(for: pokemon.species.url)
            .map{ $0.data}
            .decode(type: PokemonSpecies.self, decoder: appDecoder)
            .map{(pokemon, $0)}
            .eraseToAnyPublisher()
    }
    
    var publisher: AnyPublisher<PokemonViewModel, AppError>{
        pokemonPublisher(id)
            .flatMap{ self.speciesPublisher($0)}
            .map{ PokemonViewModel(pokemon: $0, species: $1)}
            .mapError{AppError.networkingFailed($0)}
            .eraseToAnyPublisher()
    }
}


