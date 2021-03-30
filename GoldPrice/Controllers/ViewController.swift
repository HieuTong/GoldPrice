//
//  ViewController.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        APICaller.shared.getGoldPrices { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    print(model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }


}

