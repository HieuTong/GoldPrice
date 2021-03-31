//
//  MError.swift
//  GoldPrice
//
//  Created by HieuTong on 3/31/21.
//

import Foundation

struct MError {
    var code: String
    var error: String?
    
    init(code: String, error: String) {
        self.code = code
        self.error = error
    }
}
