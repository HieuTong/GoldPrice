//
//  MessageManager.swift
//  GoldPrice
//
//  Created by HieuTong on 3/31/21.
//

import UIKit

enum MessageType {
    case success
    case error
    
    var bgColor: UIColor {
        switch self {
        case .success:
            return UIColor.green_1
        case .error:
            return UIColor.red_error
        }
    }
    
    var align: NSTextAlignment {
        return .center
    }
}

var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

let padding: CGFloat = 20
let padding_8: CGFloat = 8
let padding_12: CGFloat = 12
let padding_16: CGFloat = 16
let padding_24: CGFloat = 24



fileprivate let section = UIEdgeInsets(top: 0, left: 8, bottom: 4, right: 8)
fileprivate let heightView: CGFloat = 40
class MessageManager {
    static let shared = MessageManager()
    private lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: section.left, y: -heightView, width: screenWidth - section.left*2, height: heightView))
        view.createRoundCorner(4)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(animateHide))
        swipeGesture.direction = .up
        view.addGestureRecognizer(swipeGesture)
        return view
    }()
    
    private let titleLabel = UIMaker.makeContentLabel(fontSize: 14, color: .white, alignment: .center)
    private var timer: Timer?
    
    init() {
        titleLabel.frame = CGRect(x: padding, y: 0, width: screenWidth - section.left*2 - padding*2, height: heightView)
        bgView.addSubview(titleLabel)
    }
    
    func show(message: String, titleAction: String? = nil, type: MessageType = .success, timeInterval: TimeInterval = 5) {
        let keyWindow = UIApplication.shared.keyWindow ?? UIView()
        bgView.backgroundColor = type.bgColor
        titleLabel.text = message
        titleLabel.textAlignment = type.align
        
        keyWindow.addSubview(bgView)
        animateShow()
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(animateHide), userInfo: nil, repeats: false)
    }
    
    private func animateShow() {
        UIView.animate(withDuration: 0.35) {
            self.bgView.frame.origin.y = UIApplication.shared.statusBarFrame.height + section.top
        }
    }
    
    @objc private func animateHide() {
        timer?.invalidate()
        timer = nil
        UIView.animate(withDuration: 0.35) {
            self.bgView.frame.origin.y = -heightView
        }
    }
}
