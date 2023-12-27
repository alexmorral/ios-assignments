//
//  OrderManager.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import Foundation

class OrderManager {
    var orders = [Order]()
    
    func addOrder(order: Order) {
        orders.append(order)
    }
    
    func removeOrder(order: Order) {
        if let orderToRemoveIdx = orders.firstIndex(where: { $0 == order }) {
            orders.remove(at: orderToRemoveIdx)
        }
    }
    
    func purchaseAllOrders() {
        print("Orders have been submited")
        resetOrders()
    }
    
    func resetOrders() {
        orders.removeAll()
    }
}
