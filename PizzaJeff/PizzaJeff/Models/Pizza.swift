//
//  Pizza.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import Foundation

typealias Pizzas = [Pizza]

struct Pizza: Codable {
    let id: Int
    let name, content: String
    let imageURL: String
    let prices: [Price]

    enum CodingKeys: String, CodingKey {
        case id, name, content
        case imageURL = "imageUrl"
        case prices
    }
    
    func order(price: Price, quantity: Int) -> Order {
        let totalPrice = price.price * Double(quantity)
        return Order(name: name,
                     details: "Size \(price.size.rawValue)",
                     quantity: quantity,
                     price: totalPrice)
    }
}

// MARK: - Price
struct Price: Codable {
    let size: Size
    let price: Double
}

enum Size: String, Codable {
    case l = "L"
    case m = "M"
    case s = "S"
    case xl = "XL"
}
