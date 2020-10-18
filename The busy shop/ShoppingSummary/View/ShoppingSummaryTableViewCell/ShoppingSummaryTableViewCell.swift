//
//  ShoppingSummaryTableViewCell.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import UIKit
import FirebaseStorage

class ShoppingSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func conigureView(product: product) {
        lblProductName.text = product.description
        lblPrice.text = "R\(product.price * Float(product.quantity))"
        lblQuantity.text = "\(product.quantity)"
        let storage = Storage.storage()
        var reference: StorageReference!
        reference = storage.reference(forURL: "\(constants.imagesURL)\(product.image ?? "")")
        reference.downloadURL { (url, error) in
            if let imageUrl = url {
                let data = NSData(contentsOf: imageUrl)
                let image = UIImage(data: data! as Data)
                self.productImage.image = image
            }
        }
    }
    
}
