//
//  OfflineView.swift
//  GoldPrice
//
//  Created by HieuTong on 4/1/21.
//

import UIKit

class OfflineView: UIView {
    let imageView = UIMaker.makeImageView(image: UIImage(named: "connection"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.blue_4
        
        let title = UIMaker.makeContentLabel(fontSize: 22, text: "You are offline", color: .white, alignment: .left)
        let subtitle = UIMaker.makeContentLabel(fontSize: 14, color: .white)
        
        let subText = """
        Try
            • Turning off airplane mode
            • Turning on mobile data or Wi-Fi
            • Checking the signal in your area
        """
        let texts = subText.components(separatedBy: "•")
        let bulletFont = appFont.myriadProBold(size: 28)
        let textFont = appFont.myriadProRegular(size: 20)

        let tryAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: textFont]
        
        func formatBulletLine(text: String) -> NSAttributedString{
            return String.format(strings: ["•"],
                                 boldFont: bulletFont,
                                 boldColor: .white,
                                 inString: "• " + text,
                                 font: textFont, color: .white)
        }
        
        let partOne = NSMutableAttributedString(string: texts[0], attributes: tryAttribute)
        let partTwo = formatBulletLine(text: texts[1])
        let partThree = formatBulletLine(text: texts[2])
        let partFour = formatBulletLine(text: texts[3])

        let finalText = NSMutableAttributedString()
        finalText.append(partOne)
        finalText.append(partTwo)
        finalText.append(partThree)
        finalText.append(partFour)
        subtitle.attributedText = finalText
        
        subtitle.textAlignment = .left
        subtitle.numberOfLines = 0
        
        let view = UIMaker.makeView(background: .clear)
        view.addSubviews(views: imageView, title, subtitle)
        imageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(padding*2)
            maker.centerX.equalToSuperview()
        }
        
        title.snp.makeConstraints { (maker) in
            maker.top.equalTo(imageView.snp.bottom).offset(padding_24)
            maker.centerX.equalToSuperview()
        }
        
        subtitle.snp.makeConstraints { (maker) in
            maker.top.equalTo(title.snp.bottom).offset(padding_16)
            maker.leading.trailing.equalToSuperview().inset(padding*2)
        }
        
        addSubviews(views: view)
        view.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(padding*2)
            maker.centerY.equalToSuperview()
            maker.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
}
