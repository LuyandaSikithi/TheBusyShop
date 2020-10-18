//
//  Resolve.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation

protocol Resolve {
    func resolve<T>(_ dependency: T.Type) -> T
    func reset()
}
