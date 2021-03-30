//
//  Extensions.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import UIKit

extension UIColor {
    static func color(hex: String, alpha: CGFloat = 1) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static let blue_1 = color(hex: "0F85D1")
    static let blue_2 = color(hex: "9DCDEC")
    static let blue_3 = color(hex: "DCF2FF")
}

enum appFont: String {
    case myriadPro_bold = "MyriadPro-Bold"
    case myriadPro_regular = "MyriadPro-Regular"
    
    static func myriadPro(size: CGFloat) -> UIFont {
        return font(name: .myriadPro_bold, size: size)
    }
    
    static func myriadProRegular(size: CGFloat) -> UIFont {
        return font(name: .myriadPro_regular, size: size)
    }
    
    static func font(name: appFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name.rawValue, size: size) else { return UIFont.boldSystemFont(ofSize: size) }
        return font
    }
}
