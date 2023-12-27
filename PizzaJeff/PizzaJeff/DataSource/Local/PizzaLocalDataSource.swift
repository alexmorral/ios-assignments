//
//  PizzaLocalDataSource.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/4/21.
//

import Foundation

class PizzaLocalDataSource: PizzaDataSource {
    func getPizzaList(completion: @escaping (Result<Pizzas, ApiError>) -> Void) {
        if let path = Bundle.main.path(forResource: "PizzaList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let pizzaList = try JSONDecoder().decode(Pizzas.self, from: data)
                completion(.success(pizzaList))
            } catch {
                completion(.failure(ApiError.serializationError))
            }
        }
        completion(.failure(ApiError.networkingError))
    }
}
