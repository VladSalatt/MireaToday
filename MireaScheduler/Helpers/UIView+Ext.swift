//
//  UIView+Ext.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 13.12.2022.
//

import UIKit

extension UIView {
    
    @discardableResult
    func addSubviews(_ views: UIView...) -> UIView {
        addSubviews(views)
    }

    @discardableResult
    private func addSubviews(_ views: [UIView]) -> UIView {
        views.forEach(addSubview)
        return self
    }
}
