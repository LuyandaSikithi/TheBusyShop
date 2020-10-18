//
//  ScannerViewController.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {

    @IBOutlet weak var square: UIImageView!
    
    private var video = AVCaptureVideoPreviewLayer()
    private var products: [product]
    private var scannedProducts: [product]! {
        didSet {
            if scannedProducts.count == 1 {
                addGoToCartButton()
            }
        }
    }
    
    init(products: [product]){
        self.products = products
        self.scannedProducts = []
        super.init(nibName: "ScannerViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setUpScanner()
    }
  
    
    
    @objc func cartButtonTapped() {
        let viewController = ShoppingCartViewController(products: self.scannedProducts)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func addGoToCartButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "cart", style: .plain, target: self, action: #selector(cartButtonTapped))
    }

}

extension ScannerViewController {
    func addProductToCart(productId: String) {
        guard let products = self.scannedProducts else {
            let product = self.products.filter { $0.productId == productId}
            if let item = product.first {
                self.scannedProducts.append(item)
            }
            return
        }
        
        let product = products.filter { $0.productId == productId}
        if var item = product.first {
            self.scannedProducts = self.scannedProducts.filter { $0.productId != item.productId}
            item.quantity = item.quantity + 1
            self.scannedProducts.append(item)
        }else{
            let product = self.products.filter { $0.productId == productId}
            if let item = product.first {
                self.scannedProducts.append(item)
            }
        }
    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func setUpScanner() {
        let session = AVCaptureSession()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            session.addInput(input)
        }
        catch {
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr, .ean13, .code128]
        video = AVCaptureVideoPreviewLayer(session: session)
        
        video.frame = view.bounds
        view.layer.addSublayer(video)
        self.view.bringSubviewToFront(square)
        
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count > 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.code128{
                    
                    let productName = self.products.map { $0.productId == object.stringValue ? $0.description : object.stringValue }
                    let displayName = productName.first as? String
                    let alert = UIAlertController(title: "QR code", message: displayName, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                        if let code = object.stringValue {
                            self.addProductToCart(productId: code)
                            
                        }
                        self.dismiss(animated: true, completion: nil)
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
