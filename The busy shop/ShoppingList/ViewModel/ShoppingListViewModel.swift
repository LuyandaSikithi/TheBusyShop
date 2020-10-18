//
//  ShoppingListViewModel.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation

public class ShoppingListViewModel {
    private weak var view: ShoppingListView?
    private let repository = ResolverFactory.resolve(dependency: ShopRepository.self)
    
    
    init(view: ShoppingListView) {
        self.view = view
    }
    
    func getProducts() {
        self.view?.showLoadingIndicator()
         repository.getShoppingList(){ [weak self] results in
            self?.view?.hideLoadingIndicator()
            if let self = self {
               switch results {
               case let .success(response):
                self.view?.displayProducts(products: response)
               case let .failure(error):
                self.view?.showError(errorMessage: error.localizedDescription)
               }
           }
       }
    }
}
