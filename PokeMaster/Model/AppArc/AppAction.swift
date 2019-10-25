//
//  AppAction.swift
//  PokeMaster
//
//  Created by yl on 2019/10/23.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    
    case accountBehaviorDone(result: Result<User, AppError>)
    
    case emailValid(valid: Bool)
}
