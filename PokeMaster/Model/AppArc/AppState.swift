//
//  State.swift
//  PokeMaster
//
//  Created by yl on 2019/10/23.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

struct AppState {
    var settings = Settings()
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
        
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        var loginUser: User?
        
        var loginRequesting = false
    }
}
