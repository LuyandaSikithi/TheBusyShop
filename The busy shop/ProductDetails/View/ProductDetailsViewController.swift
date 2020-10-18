//
//  ProductDetailsViewController.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © Luyanda Sikithi. All rights reserved.
//

import UIKit
import FirebaseStorage

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    private var product: product?
    
    init(product: product){
        self.product = product
        super.init(nibName: "ProductDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        setUpView()
    }
    
    func setUpView() {
        guard let item = product else { return }
        productTitle.text = item.description
        price.text = "\(item.price * Float(item.quantity))"
        quantity.text = "\(item.quantity)"
        
        let storage = Storage.storage()
        var reference: StorageReference!
        reference = storage.reference(forURL: "\(constants.imagesURL)\(item.image ?? "")")
        reference.downloadURL { (url, error) in
            if let imageUrl = url {
                let data = NSData(contentsOf: imageUrl)
                let image = UIImage(data: data! as Data)
                self.productImage.image = image
            }
        }
    }

}
