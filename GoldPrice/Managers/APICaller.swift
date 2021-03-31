//
//  APICaller.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import Foundation

struct GetGoldPriceWorker {
    private let api = "/prices/chart_data"
    var successAction: (([GoldPrice]) -> Void)?
    var failAction: ((_ err: MError) -> Void)?

    init(successAction: (([GoldPrice]) -> Void)?, failAction: ((_ err: MError) -> Void)?) {
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        ServiceConnector.get(api, success: successResponse, fail: failResponse)
    }

    func successResponse(returnData: AnyObject) {
        if let data = returnData as? [AnyObject] {
            let rawData = data.map {(item) -> GoldPrice in
                return GoldPrice(raw: item)
            }
            successAction?(rawData)
        } else {
            successAction?([])
        }
        
    }

    func failResponse(err: MError) {
        failAction?(err)
    }
}


    
