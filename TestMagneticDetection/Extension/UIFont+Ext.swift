//
//  UIFont+Ext.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 09.04.2024.
//

import Foundation
import UIKit

enum FontType: String {
    case light300 = "Roboto-Light"
    case regular400 = "Roboto-Regular"
    case medium500 = "Roboto-Medium"
    case bold700 = "Roboto-Bold"
}

extension UIFont {

    static func font(_ type: FontType, _ size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
