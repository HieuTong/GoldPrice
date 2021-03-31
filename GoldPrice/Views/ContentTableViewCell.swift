//
//  ContentTableViewCell.swift
//  GoldPrice
//
//  Created by HieuTong on 4/1/21.
//

import UIKit

class ContentTableViewCell: BaseTableViewCell {
    static let identifier = "ContentTableViewCell"
    
    private let titleLabel = UIMaker.makeContentLabel(fontSize: 16, color: UIColor.blue_1)
    private let contentLabel = UIMaker.makeTitleLabel(fontSize: 16, color: UIColor.blue_1)
    private let line = UIMaker.makeLine(color: UIColor.blue_2)
    
    override func setupView() {
        addSubviews(views: titleLabel, contentLabel, line)
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(padding_16)
            maker.centerY.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().inset(padding_16)
        }
        
        line.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(padding_16)
            maker.bottom.trailing.equalToSuperview()
        }
    }
    
    
    func configure(with viewModel: ContentCellViewModel) {
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
    }
}
