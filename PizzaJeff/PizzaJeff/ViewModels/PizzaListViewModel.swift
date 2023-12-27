//
//  PizzaListViewModel.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/4/21.
//

import Foundation
import Combine

class PizzaListViewModel {
    var pizzaRepo: PizzaRepository!
    
    @Published private(set) var pizzas: Pizzas?
    var pizzasPublisher: Published<Pizzas?>.Publisher { $pizzas }
    
    init() {
        pizzaRepo = PizzaRepository(dataSource: PizzaLocalDataSource())
        loadPizzas()
    }
    
    private func loadPizzas() {
        pizzaRepo.getPizzas { result in
            switch result {
            case .success(let pizzas):
                self.pizzas = pizzas
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
