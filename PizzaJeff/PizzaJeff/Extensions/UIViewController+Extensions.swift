//
//  UIViewController+Extensions.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import UIKit.UIStoryboard

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static var storyboardName: String { return "Main" }
    static var storyboardIdentifier: String { return String(describing: self) }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        if let viewController = storyboard.instantiateInitialViewController() as? Self {
            return viewController
        }
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
