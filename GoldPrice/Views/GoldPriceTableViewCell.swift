//
//  GoldPriceTableViewCell.swift
//  GoldPrice
//
//  Created by HieuTong on 4/1/21.
//

import UIKit

class GoldPriceTableViewCell: BaseTableViewCell {
    static let identifier = "GoldPriceTableViewCell"
    
    private let dateLabel = UIMaker.makeContentLabel(fontSize: 16, color: UIColor.blue_1)
    private let priceLabel = UIMaker.makeTitleLabel(fontSize: 16, color: UIColor.blue_1)
    private let line = UIMaker.makeLine(color: UIColor.blue_2)
    
    override func setupView() {
        addSubviews(views: dateLabel, priceLabel, line)
        dateLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(padding_16)
            maker.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().inset(padding_16)
        }
        
        line.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(padding_16)
            maker.bottom.trailing.equalToSuperview()
        }
    }
    
    
    func configure(with viewModel: GoldPriceCellViewModel) {
        dateLabel.text = viewModel.date
        priceLabel.text = viewModel.price
    }
}
