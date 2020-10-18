//
//  ShoppingCartViewController.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var products: [product]
    private var dataSource = ListTableViewDataSource()
    
    init(products: [product]){
        self.products = products
        super.init(nibName: "ShoppingCartViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.setProducts(with: products, type: .showCart)
        setUpTableView()
    }
    
    func setUpTableView() {
        self.title = "Cart"
        tableView.register(UINib(nibName: "ShoppingCartTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingCartTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
    }

    @IBAction func CheckOutButtonTapped(_ sender: Any) {
        let viewController = ShoppingSummaryViewController(products: products)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = dataSource.getSelectedItem(row: indexPath.row)
        guard let item = selectedProduct else { return }
        let viewController = ProductDetailsViewController(product: item)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
