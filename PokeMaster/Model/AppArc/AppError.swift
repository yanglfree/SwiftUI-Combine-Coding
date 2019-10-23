//
//  AppError.swift
//  PokeMaster
//
//  Created by yl on 2019/10/23.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String{ localizedDescription }
    
    case passwordWrong
}

extension AppError: LocalizedError{
    var localizedDescription: String{
        switch self {
        case .passwordWrong:
            return "密码错误"
        }
    }
}
