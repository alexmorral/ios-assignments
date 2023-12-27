//
//  PizzaDetailViewController.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import UIKit
import SDWebImage

class PizzaDetailViewController: UIViewController, StoryboardInstantiable {

    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var pizzaImgView: UIImageView!
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var pizzaDescription: UILabel!
    @IBOutlet weak var pizzaSizeSegControl: UISegmentedControl!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountStepper: UIStepper!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: PizzaDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeViews()
    }
    
    func initializeViews() {
        pizzaImgView.sd_setImage(with: URL(string: viewModel.pizza.imageURL), completed: nil)
        pizzaNameLabel.text = viewModel.pizza.name
        pizzaDescription.text = viewModel.pizza.content
        
        configureSegmentedControl()
        configureAmountStepper()
        updateOrderPrice()
    }
    
    func configureSegmentedControl() {
        pizzaSizeSegControl.removeAllSegments()
        for size in viewModel.pizza.prices {
            pizzaSizeSegControl.insertSegment(withTitle: size.size.rawValue, at: pizzaSizeSegControl.numberOfSegments, animated: false)
        }
        if let bestPrice = CSatManager.shared.bestPriceForCurrentUser(pizza: viewModel.pizza) {
            for i in 0..<pizzaSizeSegControl.numberOfSegments {
                if pizzaSizeSegControl.titleForSegment(at: i) == bestPrice.size.rawValue {
                    pizzaSizeSegControl.selectedSegmentIndex = i
                }
            }
        }
    }
    
    func configureAmountStepper() {
        amountStepper.stepValue = 1
        amountStepper.value = Double(viewModel.currentAmount)
        amountStepper.maximumValue = 10
        amountStepper.minimumValue = 1
        updateAmountText()
    }
    
    @IBAction func sizeChanged(_ sender: Any) {
        viewModel.currentSizeSelected = pizzaSizeSegControl.titleForSegment(at: pizzaSizeSegControl.selectedSegmentIndex)
        updateOrderPrice()
    }
    
    @IBAction func amountChanged(_ sender: Any) {
        viewModel.currentAmount = Int(amountStepper.value)
        updateAmountText()
        updateOrderPrice()
    }
    
    func updateAmountText() {
        amountLabel.text = "\(viewModel.currentAmount)"
    }
    
    func updateOrderPrice() {
        let totalPrice = viewModel.currentPriceSelected().price * Double(viewModel.currentAmount)
        priceLabel.text = totalPrice.formatToEur()
    }
    
    @IBAction func instantOrderTapped(_ sender: Any) {
        let order = viewModel.createOrder()
        coordinator?.addOrderToCart(order: order)
        coordinator?.showConfirmation()
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        let order = viewModel.createOrder()
        coordinator?.addOrderToCart(order: order)
        Alerts.displayMessage(message: "Order added to your cart")
    }
}
