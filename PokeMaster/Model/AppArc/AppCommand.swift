//
//  AppCommand.swift
//  PokeMaster
//
//  Created by yl on 2019/10/23.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

protocol AppCommand {
    func excute(in store: Store)
}


struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func excute(in store: Store) {
        _ = LoginRequest(email: email, password: password)
        .publisher
            .sink(receiveCompletion: { complete in
                
                if case .failure(let error) = complete{
                    
                }
                
            }, receiveValue: { user in
                
            })
    }
}
