//
//  UIStackView+Ext.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 13.12.2022.
//

import UIKit

extension UIStackView {
    @discardableResult
    func addArrangedSubviews(_ views: UIView...) -> UIView {
        views.forEach(addArrangedSubview)
        return self
    }

    @discardableResult
    private func addArrangedSubviews(_ views: [UIView]) -> UIView {
        views.forEach(addArrangedSubview)
        return self
    }

}
