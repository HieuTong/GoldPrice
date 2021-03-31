//
//  SettingModels.swift
//  GoldPrice
//
//  Created by HieuTong on 4/1/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
