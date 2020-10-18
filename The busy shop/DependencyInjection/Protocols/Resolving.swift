//
//  Resolving.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation

protocol Resolving {
    static func resolve<T>(dependency: T.Type) -> T
    static func reset()
}
