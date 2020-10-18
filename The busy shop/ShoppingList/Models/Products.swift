//
//  Products.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation

struct Products {
    var list: [product]
}

struct product {
    let productId: String
    let description: String?
    let image: String?
    let price: Float
    var quantity: Int
}
