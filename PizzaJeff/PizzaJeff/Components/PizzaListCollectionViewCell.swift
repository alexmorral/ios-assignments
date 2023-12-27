//
//  PizzaListCollectionViewCell.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import UIKit
import SDWebImage

protocol PizzaCollectionCellDelegate: AnyObject {
    func addToCartTapped(order: Order)
}

class PizzaListCollectionViewCell: UICollectionViewCell {
    static let identifier = "PizzaListCollectionViewCell"
    
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    weak var delegate: PizzaCollectionCellDelegate?
    var pizza: Pizza?
    
    func setup(pizza: Pizza) {
        self.pizza = pizza
        
        titleLabel.text = pizza.name
        let bestPrice = CSatManager.shared.bestPriceForCurrentUser(pizza: pizza)
        secondaryLabel.text = bestPrice?.price.formatToEur()
        if let size = bestPrice?.size.rawValue {
            thirdLabel.text = "Size \(size)"
        }
        imgView.sd_setImage(with: URL(string: pizza.imageURL), completed: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard let pizza = pizza,
              let bestPrice = CSatManager.shared.bestPriceForCurrentUser(pizza: pizza)
        else { return }
        
        let order = pizza.order(price: bestPrice, quantity: 1)
        delegate?.addToCartTapped(order: order)
    }
}
