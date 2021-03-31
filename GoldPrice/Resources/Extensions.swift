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
    static let green_1 = color(hex: "00C6A2")
    static let red_error = color(hex: "F73C52")
}

enum appFont: String {
    case myriadPro_bold = "MyriadPro-Bold"
    case myriadPro_regular = "MyriadPro-Regular"
    
    static func myriadProBold(size: CGFloat) -> UIFont {
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

extension UIView {
    @objc func createRoundCorner(_ radius: CGFloat = 7) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

extension UINavigationController {
    func setNavBarTitle(color: UIColor, size: CGFloat) {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: appFont.myriadProBold(size: size)]
    }
    
    func setBackgroundAndShadowImage(bgColor: UIColor, sdColor: UIColor) {
        navigationBar.setBackgroundImage(UIImage.imageFromColor(color: bgColor), for: .default)
        navigationBar.shadowImage = UIImage.imageFromColor(color: sdColor)
    }
}

extension UIImage {
    static func imageFromColor(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension String {
    static func formattedDate(string: String, format: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        guard let date = inputFormatter.date(from: string) else {
            return string
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format

        return outputFormatter.string(from: date)
    }
}

extension UIView {
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    @discardableResult
    public func height(_ height: CGFloat, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = isActive
        return constraint
    }
}


