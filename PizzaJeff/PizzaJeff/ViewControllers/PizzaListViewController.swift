//
//  PizzaListViewController.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import UIKit
import Combine

class PizzaListViewController: UIViewController, StoryboardInstantiable {
    
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var pizzasCollectionView: UICollectionView!
    
    var viewModel = PizzaListViewModel()
    
    private var bindingsSet = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pizza Jeff"
        configureNavigationBar()
        configureCollectionView()
        configureBindings()
    }
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(logoutTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.fill"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cartTapped))
    }
    
    func configureBindings() {
        let pizzasValueHandler: (Pizzas?) -> Void = { [weak self] _ in
            self?.pizzasCollectionView.reloadData()
        }
        
        viewModel.pizzasPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: pizzasValueHandler)
            .store(in: &bindingsSet)
    }
    
    @objc func logoutTapped() {
        Alerts.showConfirmationActionSheet(vcToPresent: self,
                                           title: "Confirm",
                                           description: "Are you sure you want to log out?",
                                           cancelText: "Cancel",
                                           actionText: "Log out",
                                           isDestructive: false) { [weak self] in
            self?.coordinator?.logoutUser()
        }
    }
    
    @objc func cartTapped() {
        coordinator?.showConfirmation()
    }
    
    func configureCollectionView() {
        pizzasCollectionView.dataSource = self
        pizzasCollectionView.delegate = self
        self.view.layoutIfNeeded()
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: pizzasCollectionView.frame.width, height: 120)
        flowLayout.sectionInset = sectionInsets
        flowLayout.minimumLineSpacing = sectionInsets.left
        pizzasCollectionView.collectionViewLayout = flowLayout
    }
    
}

extension PizzaListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pizzas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PizzaListCollectionViewCell.identifier,
            for: indexPath) as? PizzaListCollectionViewCell,
              let pizzaList = viewModel.pizzas
        else { return UICollectionViewCell() }
        let pizza = pizzaList[indexPath.row]
        cell.setup(pizza: pizza)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let pizzaList = viewModel.pizzas else { return }
        let pizza = pizzaList[indexPath.row]
        coordinator?.showPizzaDetail(pizza: pizza)
    }
}

extension PizzaListViewController: PizzaCollectionCellDelegate {
    func addToCartTapped(order: Order) {
        coordinator?.addOrderToCart(order: order)
        Alerts.displayMessage(message: "Order added to your cart")
    }
}
