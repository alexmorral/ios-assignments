//
//  CSatManager.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import Foundation

//This class could make calls to an API to get the latest information.
class CSatManager {
    static let shared = CSatManager()
    
    var userType: UserType = .single
    var isMovieUpsellShown = false
    
    // These are the ordering where the Customer satisfaction scores best for every type
    // of user. These orderings could even come from an API or somthing and not be hardcoded (source: PDF)
    let singlePriceOrdering = HardCodedOrdering(ordering: Size.m, Size.l, Size.s, Size.xl)
    let marriedPriceOrdering = HardCodedOrdering(ordering: Size.xl, Size.l, Size.m, Size.s)
    
    public func start(userType: UserType) {
        self.userType = userType
    }
    
    // Gets the price that gives more Customer Satisfaction for the user type.
    func bestPriceForCurrentUser(pizza: Pizza) -> Price? {
        switch userType {
        case .single:
            let realPrices = pizza.prices.lazy.filter({ self.singlePriceOrdering.contains($0.size) })
            let sortedPries = realPrices.sorted(by: singlePriceOrdering.areInIncreasingOrder(by: { $0.size }))
            return sortedPries.first
        case .married:
            let realPrices = pizza.prices.lazy.filter({ self.marriedPriceOrdering.contains($0.size) })
            let sortedPries = realPrices.sorted(by: marriedPriceOrdering.areInIncreasingOrder(by: { $0.size }))
            return sortedPries.first
        }
    }
    
    func shouldShowMovieUpsellPopup() -> Bool {
        return userType == .married && !isMovieUpsellShown
    }
}
