//
//  GoldPrice.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import Foundation

struct GoldPrice: Codable {
    let amount: String
    let date: String
}

struct AppError: Codable {
    let error: String
    let code: Int
}
