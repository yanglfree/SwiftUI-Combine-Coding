//
//  LoginRequest.swift
//  PokeMaster
//
//  Created by yl on 2019/10/23.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct LoginRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError>{
        Future{ promise in
            DispatchQueue.global()
                .asyncAfter(deadline: .now() + 1.5) {
                    if self.password == "password"{
                        let user = User(email: self.email, favoritePokemonIDs: [])
                        promise(.success(user))
                    }else{
                        promise(.failure(.passwordWrong))
                    }
                    
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
