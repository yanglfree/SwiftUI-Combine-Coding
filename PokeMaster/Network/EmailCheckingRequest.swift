//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by yl on 2020/12/28.
//  Copyright © 2020 Liang. All rights reserved.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    
    let email: String
    
    var publisher: AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if self.email.lowercased() == "yangliangsky@gmail.com" {
                    promise(.success(true))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    init(email: String) {
        self.email = email
    }
}
