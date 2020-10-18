//
//  ListTableViewDataSource.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import Foundation
import UIKit

enum tableViewCellType {
    case showCart
    case showSummary
}
class ListTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var products: [product]?
    private var cellType: tableViewCellType!
    
    func setProducts(with products: [product], type: tableViewCellType) {
        self.products = products
        self.cellType = type
    }
    
    func getSelectedItem(row: Int) -> product? {
        guard let product =  products else {
            return nil
        }
        return product[row]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let product =  products else {
            return 0
        }
        return product.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellType == .showCart {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell") as? ShoppingCartTableViewCell else { return UITableViewCell() }
            let product = products?[indexPath.row]
            if let item = product {
                cell.configureView(product: item)
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingSummaryTableViewCell") as? ShoppingSummaryTableViewCell else { return UITableViewCell() }
            let product = products?[indexPath.row]
            if let item = product {
                cell.conigureView(product: item)
            }
            return cell
        }
    }

}
