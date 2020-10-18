//
//  DependencyRegister.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation

func registerAllDependencies() {
    let container = DIContainer.instance
    container.register(dependency: ShopRepository.self, implementation: { _ in
        return ShopRepositoryImplementation()
    }, objectScope: .weak)
}
