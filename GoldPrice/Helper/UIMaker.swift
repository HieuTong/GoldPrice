//
//  UIMaker.swift
//  GoldPrice
//
//  Created by HieuTong on 3/31/21.
//

import UIKit


struct UIMaker {
    
    // MARK: - View
    
    static func makeLine(color: UIColor = .white, height: CGFloat = 1) -> UIView {
        let view = UIMaker.makeView(background: color)
        view.height(height)
        return view
    }
    
    static func makeView(background: UIColor = .white) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = background
        return view
    }
    
    // MARK: - Label
    
    static func makeTitleLabel(fontSize: CGFloat = 16,
                                 text: String? = nil,
                                 isBold: Bool = true,
                                 color: UIColor = .black,
                                 numberOfLines: Int = 0,
                                 alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = isBold ? appFont.myriadProBold(size: fontSize): appFont.myriadProRegular(size: fontSize)
        label.textColor = color
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    static func makeContentLabel(fontSize: CGFloat,
                                   text: String? = nil,
                                   isBold: Bool = false,
                                   color: UIColor = .black,
                                   numberOfLines: Int = 0,
                                   alignment: NSTextAlignment = .left) -> UILabel{
        let label = UILabel()
        label.font = isBold ? appFont.myriadProBold(size: fontSize): appFont.myriadProRegular(size: fontSize)
        label.textColor = color
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
}
