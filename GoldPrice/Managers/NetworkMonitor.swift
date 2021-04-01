//
//  NetworkMonitor.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import Foundation
import Network

@available(iOS 12.0, *)
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false

    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
