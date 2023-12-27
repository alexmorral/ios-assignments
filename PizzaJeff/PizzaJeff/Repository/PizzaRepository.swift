//
//  PizzaRepository.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/4/21.
//

import Foundation

class PizzaRepository {
    var dataSource: PizzaDataSource!
    
    init(dataSource: PizzaDataSource) {
        self.dataSource = dataSource
    }
    
    func getPizzas(completion: @escaping (Result<Pizzas, ApiError>) -> Void) {
        dataSource.getPizzaList(completion: completion)
    }
}
