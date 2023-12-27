//
//  ActionButton.swift
//  PizzaJeff
//
//  Created by Alex Morral on 15/2/21.
//

import UIKit


enum ActionButtonType {
    case primary, secondary
}

class ActionButton: UIButton {
    
    var actionButtonType: ActionButtonType = .primary
    
    override var isEnabled: Bool {
        didSet { configureDisabledButton() }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    init(type: ActionButtonType = .primary) {
        super.init(frame: .zero)
        self.actionButtonType = type
        configureView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() {
        layer.cornerRadius = 12
        switch actionButtonType {
        case .primary:
            backgroundColor = .systemBlue
            setTitleColor(.white, for: .normal)
        case .secondary:
            backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
            setTitleColor(.lightGray, for: .normal)
        }
    }
    
    func configureDisabledButton() {
        if isEnabled {
            configureView()
        } else {
            backgroundColor = .clear
            setTitleColor(.lightGray, for: .normal)
        }
    }

}
