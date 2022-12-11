//
//  UILabel+Ext.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 11.12.2022.
//

import UIKit

extension UILabel {
    func setTextOrHide(_ text: String?) {
        self.text = text
        isHidden = text == nil || text == ""
    }
}
