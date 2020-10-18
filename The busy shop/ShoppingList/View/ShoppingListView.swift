//
//  ShoppingListView.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation

protocol ShoppingListView: class {
    func displayProducts(products: Products) 
    func showError(errorMessage: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}
