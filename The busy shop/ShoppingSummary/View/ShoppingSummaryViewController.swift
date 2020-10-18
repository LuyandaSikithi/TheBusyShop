//
//  ShoppingSummaryViewController.swift
//  The busy shop
//
//  Created by Luyanda Sikithi on 2020/10/17.
//  Copyright © 2020 Luyanda Sikithi. All rights reserved.
//

import UIKit

import UIKit

class ShoppingSummaryViewController: UIViewController {

    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderTime: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    private var products: [product]
    private var dataSource = ListTableViewDataSource()
    private var totalAmount: Float!
    private var orderDate: String!
    private var orderTime: String!
    
    init(products: [product]){
        self.products = products
        self.totalAmount = 0
        super.init(nibName: "ShoppingSummaryViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.setProducts(with: products, type: .showSummary)
        setUpTableView()
        getDateAndTime()
        calculateTotalAmount()
    }
    
    func setUpTableView() {
        self.title = "Summary"
        tableView.register(UINib(nibName: "ShoppingSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingSummaryTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
    }
    
    func getDateAndTime(){
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: now)
        lblOrderDate.text = dateString
        orderDate = dateString
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: now)
        lblOrderTime.text = timeString
        orderTime = timeString
    }
    
    func calculateTotalAmount() {
        for product in self.products {
            totalAmount = totalAmount + (product.price * Float(product.quantity))
        }
        self.lblTotal.text = "R\(totalAmount ?? 0.0)"
    }
    @IBAction func confirmButtonTapped(_ sender: Any) {
        shareToAccountSection()
    }
    
    
}

extension ShoppingSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ShoppingSummaryViewController {
    func shareToAccountSection() {
        let toSectionView = getToSectionView()
        if let toSectionView = toSectionView {
            view.addSubview(toSectionView)
        }
        let toSectionRect = toSectionView?.bounds

        UIGraphicsBeginImageContextWithOptions(toSectionRect?.size ?? CGSize.zero, _: false, _: 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            toSectionView?.layer.render(in: context)
        }
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        toSectionView?.removeFromSuperview()

        if screenshot != nil {
            let activityController = UIActivityViewController(activityItems: [screenshot].compactMap { $0 }, applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = view
            present(activityController, animated: true)
        }
    }

    func getToSectionView() -> UIView? {
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.backgroundColor = UIColor.white
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.alignment = .fill
        for formItemView in self.view.subviews {
            if formItemView != confirmButton {
                formItemView.translatesAutoresizingMaskIntoConstraints = false
                verticalStackView.addArrangedSubview(formItemView)
                formItemView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
                formItemView.heightAnchor.constraint(equalToConstant: formItemView.frame.size.height).isActive = true
            }
        }
        verticalStackView.setNeedsLayout()
        verticalStackView.layoutIfNeeded()
        return verticalStackView
    }
}
