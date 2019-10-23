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
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                
            }, receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            })
    }
}


struct WriteUserAppCommand: AppCommand {
    let user: User
    func excute(in store: Store) {
        try? FileHelper.writeJSON(
            user,
            to: .documentDirectory,
            fileName: "user.json")
    }
}
