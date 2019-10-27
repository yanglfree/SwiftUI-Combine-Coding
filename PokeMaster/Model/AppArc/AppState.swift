//
//  State.swift
//  PokeMaster
//
//  Created by yl on 2019/10/23.
//  Copyright © 2019 OneV's Den. All rights reserved.
//
import Combine
import Foundation

struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
}

extension AppState{
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        
        enum AccountBehavior: CaseIterable{
            case register, login
        }
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false

        var isEmailValid: Bool = false
        
        class AccountChecker{
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never>{
                let remoteVerify = $email
                    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        
                        switch (validEmail, canSkip){
                        case (false, _):
                            //邮箱检验失败
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            //联网校验
                            return EmailCheckingRequest(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            //校验成功
                            return Just(true).eraseToAnyPublisher()
                        }
                    }
                
                let emailLocalValid = $email.map { $0.isValidEmailAddress}
                
                let canSkipRemoteVerify = $accountBehavior.map{ $0 == .login}
                
                return Publishers.CombineLatest3(emailLocalValid, canSkipRemoteVerify, remoteVerify)
                    .map{ $0 && ($1 || $2)}
                    .eraseToAnyPublisher()
            }
        }
        
        var checker = AccountChecker()
        
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        
        var loginRequesting = false
        var loginError: AppError?
    }
}

extension AppState{
    struct PokemonList {
        var pokemons: [Int: PokemonViewModel]?
        var loadingPokemons = false
        var allPokemonsByID: [PokemonViewModel]{
            guard let pokemons = pokemons?.values else {
                return []
            }
            return pokemons.sorted { $0.id < $1.id }
        }
    }
}
