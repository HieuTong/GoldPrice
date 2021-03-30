//
//  ViewController.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import UIKit
import Reachability

class ViewController: UIViewController {

    let reachability = try! Reachability()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        if NetworkMonitor.shared.isConnected {
//            print("you're connected")
//        } else {
//            print("you're not connected")
//        }
        
        //fetchData()
        handleNetwork()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func fetchData() {
        APICaller.shared.getGoldPrices { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    print(model)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func handleNetwork() {
            self.reachability.whenReachable = { reachability in
                DispatchQueue.main.async {
                    print("connect")
                    self.view.backgroundColor = .green
                }
            }
            self.reachability.whenUnreachable = { _ in
                print("not")
                DispatchQueue.main.async {
                    self.view.backgroundColor = .red
                }
            }
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable {
            DispatchQueue.main.async {
                print("connect")
                self.view.backgroundColor = .green
            }
        } else {
            DispatchQueue.main.async {
                print("not")
                self.view.backgroundColor = .red
            }
        }
    }

    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

}

