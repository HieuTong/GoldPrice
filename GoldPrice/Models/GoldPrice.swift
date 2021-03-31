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
    
    init(raw: AnyObject) {
        amount = raw["amount"] as? String ?? ""
        date = raw["date"] as? String ?? ""
    }
}

struct AppError: Codable {
    let error: String
    let code: Int
}
