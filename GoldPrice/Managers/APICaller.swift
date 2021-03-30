//
//  APICaller.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constans {
        static let baseAPIURL = "https://rth-recruitment.herokuapp.com/api"
        static let token = "76524a53ee60602ac3528f38"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    // MARK: - Prices
    
    public func getGoldPrices(completion: @escaping (Result<[GoldPrice], Error>) -> Void) {
        createRequest(with: URL(string: Constans.baseAPIURL + "/prices/chart_data"), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([GoldPrice].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
        
    }
    
    enum HTTPMethod: String {
        case GET
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else {
            return
        }

        var request = URLRequest(url: apiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(Constans.token)", forHTTPHeaderField: "X-App-Token")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        
        completion(request)
    }
}
