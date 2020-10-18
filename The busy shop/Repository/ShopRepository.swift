//
//  ShopRepository.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase

protocol ShopRepository {
    func getShoppingList(completion: @escaping (Result<Products, Error>) -> Void)
}

public class ShopRepositoryImplementation: ShopRepository {
    func getShoppingList(completion: @escaping (Result<Products, Error>) -> Void) {
        Auth.auth().signIn(withEmail: constants.email, password: constants.password) { authResults, error in
            if error == nil {
                let ref = Database.database().reference()
                var products = Products(list: [])
                
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    for shopProduct in snapshot.children.allObjects as! [DataSnapshot] {
                        guard let shopItem = shopProduct.value as? [String:Any] else { return }
                        
                        let description = shopItem["description"] as? String
                        let image = shopItem["image"] as? String
                        guard let price = shopItem["price"] as? Float else { return }
                        let item = product(productId: shopProduct.key, description: description, image: image, price: price, quantity:1)
                        products.list.append(item)
                    }
                    completion(Result.success(products))

                }) { (error) in
                    completion(Result.failure(error))
                }
            }
            
        }
    }

}
