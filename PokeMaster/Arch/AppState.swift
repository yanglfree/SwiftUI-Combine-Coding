//
//  AppState.swift
//  PokeMaster
//
//  Created by yl on 2020/12/26.
//  Copyright © 2020 Liang. All rights reserved.
//

import Foundation

struct AppState {
    var settings = Settings()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        
        enum AccountBehaivior: CaseIterable {
            case register, login
        }
        
//        @UserDefaultsStorage(key: "showEnglishName")
        var showEnglishName = true
        
//        @UserDefaultsStorage(key: "sorting")
        var sorting: Sorting = Sorting.id
        
        var showFavoriteOnly: Bool = false
        
        var accountBehavior = AccountBehaivior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        
        var loginRequesting = false
        var loginError: AppError?
    }
}
