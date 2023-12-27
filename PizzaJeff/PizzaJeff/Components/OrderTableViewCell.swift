//
//  OrderTableViewCell.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    static let identifier = "OrderTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var order: Order?
    func setup(order: Order) {
        self.order = order
        nameLabel.text = order.name
        detailsLabel.text = order.details
        amountLabel.text = "\(order.quantity)"
        priceLabel.text = order.price.formatToEur()
    }

}
