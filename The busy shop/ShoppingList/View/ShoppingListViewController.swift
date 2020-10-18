//
//  ShoppingListViewController.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var btnScan: UIButton!
    
    private var products: Products!
    lazy var viewModel: ShoppingListViewModel = {
        return ShoppingListViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.isHidden = true
        header.isHidden = true
        btnScan.isHidden = true
        self.viewModel.getProducts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    @IBAction func scanProducts(_ sender: Any) {
        let viewController = ScannerViewController(products: self.products.list)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
extension ShoppingListViewController: ShoppingListView {
    func displayProducts(products: Products) {
        self.products = products
        hideLoadingIndicator()
    }
    
    func showError(errorMessage: String) {

    }
    
    func showLoadingIndicator() {
        showActivityIndicatory()
    }
    
    func hideLoadingIndicator() {
        hideActivityIndicatory()
        message.isHidden = false
        header.isHidden = false
        btnScan.isHidden = false
    }
    
}
