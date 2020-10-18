//
//  ResolverFactory.swift
//  The busy shop
//
//  Created by Luyanda Sikithii on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation

import Swinject

class ResolverFactory {
    private static var container: Resolve = DIContainer.instance
}

extension ResolverFactory: Resolving {
    static func resolve<T>(dependency: T.Type) -> T {
        return container.resolve(dependency)
    }
    static func reset() {
        container.reset()
    }
}
