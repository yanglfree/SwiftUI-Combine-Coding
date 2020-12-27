//
//  UserDefaultsStorage.swift
//  PokeMaster
//
//  Created by yl on 2020/12/27.
//  Copyright © 2020 Liang. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage<T> {
    
    var value: T
    let key: String
    
    init(key: String) {
        self.key = key
        value = UserDefaults.standard.value(forKey: key) as! T
    }
    
    var wrappedValue: T{
        set {
            value = newValue
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
        
        get {
            value
        }
    }
}
