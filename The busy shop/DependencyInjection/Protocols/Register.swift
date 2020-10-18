//
//  Register.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation
import Swinject

protocol Register {
    func register<T>(dependency: T.Type,
                     implementation: @escaping (_ resolver: Resolve) -> T,
                     objectScope: ObjectScope)
}
