//
//  UIView+Extensions.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation
import UIKit

extension UIView {
    func addAndPin(view: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(view)
        view.pin(to: self, insets: insets)
    }

    func pin(to pinned: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: pinned.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: pinned.bottomAnchor, constant: -1 * insets.bottom),
            leadingAnchor.constraint(equalTo: pinned.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: pinned.trailingAnchor, constant: -1 * insets.right)
        ])
    }

    func removeSubviews() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
    }
}
