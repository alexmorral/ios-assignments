//
//  UpsellPopup.swift
//  PizzaJeff
//
//  Created by Alex Morral on 15/2/21.
//

import UIKit
import SnapKit

struct UpsellPopupConfiguration {
    let title: String
    let description: String
    let leftButtonText: String
    let rightButtonText: String
}

class UpsellPopupViewController: UIViewController {
    var configuration: UpsellPopupConfiguration?
    
    var leftBtnAction: ClosureAction?
    var rightBtnAction: ClosureAction?
    
    func configure(configuration: UpsellPopupConfiguration, leftButtonAction: @escaping ClosureAction, rightButtonAction: @escaping ClosureAction) {
        self.configuration = configuration
        self.leftBtnAction = leftButtonAction
        self.rightBtnAction = rightButtonAction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        view.backgroundColor = .clear
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowRadius = 9
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.masksToBounds = false
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        let stackContainer = UIStackView()
        stackContainer.axis = .vertical
        stackContainer.spacing = 20
        
        containerView.addSubview(stackContainer)
        stackContainer.snp.makeConstraints { (make) in
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.top.equalTo(containerView).offset(20)
            make.bottom.equalTo(containerView).offset(-20)
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = configuration?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 23)
        stackContainer.addArrangedSubview(titleLabel)
        
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.text = configuration?.description
        stackContainer.addArrangedSubview(descLabel)
        
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 20
        buttonsStackView.distribution = .fillEqually
        stackContainer.addArrangedSubview(buttonsStackView)
        
        let leftButton = ActionButton(type: .secondary)
        leftButton.setTitle(configuration?.leftButtonText, for: .normal)
        leftButton.addTarget(self, action: #selector(leftActionTapped), for: .touchUpInside)
        
        let rightButton = ActionButton(type: .primary)
        rightButton.setTitle(configuration?.rightButtonText, for: .normal)
        rightButton.addTarget(self, action: #selector(rightActionTapped), for: .touchUpInside)
        
        buttonsStackView.addArrangedSubview(leftButton)
        buttonsStackView.addArrangedSubview(rightButton)
    }
    
    @objc func leftActionTapped() {
        self.dismiss(animated: true, completion: nil)
        if let action = leftBtnAction {
            action()
        }
    }
    
    @objc func rightActionTapped() {
        self.dismiss(animated: true, completion: nil)
        if let action = rightBtnAction {
            action()
        }
    }
    
    
}
