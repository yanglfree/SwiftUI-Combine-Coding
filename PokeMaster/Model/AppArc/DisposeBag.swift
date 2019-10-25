//
//  DisposeBag.swift
//  PokeMaster
//
//  Created by yl on 2019/10/25.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Combine

class DisposeBag {
    private var values: [AnyCancellable] = []
    
    func add(_ value: AnyCancellable){
        values.append(value)
    }
}

extension AnyCancellable{
    func add(to bag: DisposeBag){
        bag.add(self)
    }
}
