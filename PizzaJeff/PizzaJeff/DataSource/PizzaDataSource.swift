//
//  PizzaDataSource.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/4/21.
//

import Foundation

protocol PizzaDataSource {
    func getPizzaList(completion: @escaping (Result<Pizzas, ApiError>) -> Void)
}
