//
//  AppAction.swift
//  PokeMaster
//
//  Created by yl on 2020/12/27.
//  Copyright © 2020 Liang. All rights reserved.
//

import Foundation


enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
    case logout
}
