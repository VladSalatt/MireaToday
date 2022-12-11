//
//  UIColor+Ext.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 11.12.2022.
//

import UIKit

extension UIColor {
//    static let darkGreenColor = UIColor(hex: 0x5FD068)
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF

        self.init(
            red: .init(red) / 255,
            green: .init(green) / 255,
            blue: .init(blue) / 255,
            alpha: alpha
        )
    }
}
