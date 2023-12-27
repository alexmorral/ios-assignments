//
//  Alerts.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import UIKit
import SwiftEntryKit

class Alerts {
    static func showConfirmationActionSheet(vcToPresent: UIViewController, title: String? = nil, description: String? = nil, cancelText: String = "Cancel", actionText: String, isDestructive: Bool = true, actionSelected: @escaping () -> Void) {
        let alertVC = UIAlertController(title: title, message: description, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: cancelText, style: .cancel, handler: nil)
        let actionBtn = UIAlertAction(title: actionText, style: isDestructive ? .destructive : .default) { (action) in
            actionSelected()
        }
        alertVC.addAction(cancelBtn)
        alertVC.addAction(actionBtn)
        vcToPresent.present(alertVC, animated: true, completion: nil)
    }
    
    static func showErrorAlert(vcToPresent: UIViewController, error: ApiError) {
        let alert = UIAlertController(title: "Error", message: error.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vcToPresent.present(alert, animated: true, completion: nil)
    }
    
    static func displayMessage(message: String) {
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .color(color: EKColor(UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.statusBar = .dark

        let title = EKProperty.LabelContent(text: "", style: .init(font: UIFont.systemFont(ofSize: 17), color: EKColor(.black)))
        let description = EKProperty.LabelContent(text: message, style: .init(font: UIFont.systemFont(ofSize: 17), color: EKColor(.darkGray)))
    
        let simpleMessage = EKSimpleMessage(title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)

        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    static func showMovieUpsell(in vc: UIViewController, leftAction: @escaping ClosureAction, rightAction: @escaping ClosureAction) {
        let popupConfiguration = UpsellPopupConfiguration(title: "Watch a movie while eating your pizza",
                                                          description: "We know people like to watch a movie while eating their pizzas. That's why we are offering at discounted price a movie.",
                                                          leftButtonText: "No thanks",
                                                          rightButtonText: "Add to cart")
        showUpsellPopup(in: vc,
                        configuration: popupConfiguration,
                        leftAction: leftAction, rightAction: rightAction)
    }
    
    static func showUpsellPopup(in vc: UIViewController, configuration: UpsellPopupConfiguration, leftAction: @escaping ClosureAction, rightAction: @escaping ClosureAction) {
        let upsellPopup = UpsellPopupViewController()
        upsellPopup.modalPresentationStyle = .overCurrentContext
        upsellPopup.configure(configuration: configuration, leftButtonAction: leftAction, rightButtonAction: rightAction)
        vc.present(upsellPopup, animated: true, completion: nil)
    }
}
