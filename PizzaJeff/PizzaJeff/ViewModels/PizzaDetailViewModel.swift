//
//  PizzaDetailViewModel.swift
//  PizzaJeff
//
//  Created by Alex Morral on 26/11/21.
//

import Foundation

class PizzaDetailViewModel {
    var currentAmount: Int = 1
    var pizza: Pizza!
    
    var currentSizeSelected: String?
    
    init(pizza: Pizza) {
        self.pizza = pizza
        self.currentSizeSelected = pizza.prices.first?.size.rawValue
    }
    
    func createOrder() -> Order {
        return pizza.order(price: currentPriceSelected(), quantity: currentAmount)
    }
    
    func currentPriceSelected() -> Price {
        return pizza.prices.first(where: { $0.size.rawValue == currentSizeSelected })!
    }
}
