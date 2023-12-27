//
//  PizzaRemoteDataSource.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/4/21.
//

import Foundation

class PizzaRemoteDataSource: PizzaDataSource {
    func getPizzaList(completion: @escaping (Result<Pizzas, ApiError>) -> Void) {
        let url = URL(string: "https://gist.github.com/eliseo-juan/c9c124b0899ae9adc254146783c0b764/raw")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(ApiError.noDataReceived))
                return
            }
            if let _ = error {
                completion(.failure(ApiError.networkingError))
                return
            }
            
            do {
                let pizzaList = try JSONDecoder().decode(Pizzas.self, from: data)
                completion(.success(pizzaList))
            } catch {
                completion(.failure(ApiError.serializationError))
            }
        }
        task.resume()
    }
}
