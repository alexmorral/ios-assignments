//
//  ViewController.swift
//  PizzaJeff
//
//  Created by Alex Morral on 8/2/21.
//

import UIKit



class LoginViewController: UIViewController, StoryboardInstantiable {
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    
    var mainCoordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: Any) {
        let typeSelected: UserType = userTypeSegmentedControl.selectedSegmentIndex == 0 ? .single : .married
        loginUserAs(userType: typeSelected)
    }
    
    func loginUserAs(userType: UserType) {
        let navController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController: navController)
        mainCoordinator?.navigationController.modalPresentationStyle = .fullScreen
        mainCoordinator?.navigationController.modalTransitionStyle = .crossDissolve
        mainCoordinator?.start(userType: userType)
        self.present(navController, animated: true, completion: nil)
    }
}

