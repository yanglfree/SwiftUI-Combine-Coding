//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by yl on 2019/10/24.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Combine
import Foundation

struct EmailCheckingRequest {
    let email: String
    var publisher: AnyPublisher<Bool, Never>{
        Future<Bool, Never>{ promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if self.email.lowercased() == "yangliangsky@gmail.com"{
                    promise(.success(false))
                }else{
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
