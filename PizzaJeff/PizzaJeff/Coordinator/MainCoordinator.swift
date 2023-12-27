//
//  MainCoordinator.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import UIKit
import SwiftEntryKit

class MainCoordinator {
    var navigationController: UINavigationController
    
    let orderManager = OrderManager()
    
    var userType: UserType = .single
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(userType: UserType) {
        orderManager.resetOrders()
        self.userType = userType
        CSatManager.shared.start(userType: userType)
        let vc = PizzaListViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func logoutUser() {
        navigationController.dismiss(animated: true, completion: nil)
        orderManager.resetOrders()
    }
    
    func showPizzaDetail(pizza: Pizza) {
        let viewModel = PizzaDetailViewModel(pizza: pizza)
        let pizzaDetailVC = PizzaDetailViewController.instantiate()
        pizzaDetailVC.coordinator = self
        pizzaDetailVC.viewModel = viewModel
        navigationController.pushViewController(pizzaDetailVC, animated: true)
    }
    
    func showConfirmation() {
        let confirmationVC = ConfirmationViewController.instantiate()
        confirmationVC.coordinator = self
        confirmationVC.orders = orderManager.orders
        let confirmationNavVC = UINavigationController(rootViewController: confirmationVC)
        navigationController.present(confirmationNavVC, animated: true, completion: nil)
    }
    
    func addOrderToCart(order: Order) {
        orderManager.addOrder(order: order)
    }
    
    func confirmOrders() {
        orderManager.purchaseAllOrders()
    }
}
