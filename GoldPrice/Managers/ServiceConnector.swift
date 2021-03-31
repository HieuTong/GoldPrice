//
//  ServiceConnector.swift
//  GoldPrice
//
//  Created by HieuTong on 4/1/21.
//

import Alamofire

struct ServiceConnector {
    static let baseAPIURL = "https://rth-recruitment.herokuapp.com/api"
    static let token = "76524a53ee60602ac3528f38"
    static fileprivate var connector = AlamofireConnector()
    
    static func getHeader() -> [String: String]? {
        let header = [
            "Content-Type": "application/json",
            "X-App-Token": token
        ]
        return header
    }
    
    private static func getUrl(from api: String) -> URL? {
        let apiUrl = baseAPIURL + api
        return URL(string: apiUrl)
    }
    
    
    static func get(_ api: String,
                    params: [String: Any]? = nil,
                    success: @escaping (_ result: AnyObject) -> Void,
                    fail: ((_ error: MError) -> Void)? = nil) {
        
        let header = getHeader()
        get(api, params: params, header: header, success: success, fail: fail)
    }


    static func get(_ api: String,
                    params: [String: Any]? = nil,
                    header: [String: String]?,
                    success: @escaping (_ result: AnyObject) -> Void,
                    fail: ((_ error: MError) -> Void)? = nil) {
        
        let apiUrl = getUrl(from: api)
        connector.request(withApi: apiUrl,
                          method: .get,
                          params: params,
                          header: header,
                          success: success,
                          fail: fail)
    }
}

struct AlamofireConnector {
    func request(withApi api: URL?,
                 method: HTTPMethod,
                 params: [String: Any]? = nil,
                 header: [String: String]? = nil,
                 success: @escaping (_ result: AnyObject) -> Void,
                 fail: ((_ error: MError) -> Void)?) {
        guard let api = api else { return }
        let encoding: ParameterEncoding = method == .post || method == .put || method == .delete ? JSONEncoding.default : URLEncoding.httpBody
        
        Alamofire.request(api, method: method, parameters: params, encoding: encoding, headers: header)
            .responseJSON { (response) in
                self.response(response: response,
                              withSuccessAction: success,
                              failAction: fail)
        }
    }
    
    func response(response: DataResponse<Any>,
                  withSuccessAction success: @escaping (_ result: AnyObject) -> Void,
                  failAction fail: ((_ error: MError) -> Void)?) {
        if let code = response.response?.statusCode, code != 200 {
            
            if let message = (response.result.value as AnyObject)["error"] as? String {
                let error = MError(code: "error_\(code)", error: message)
                fail?(error)
                return
            }
            
            let error = MError(code: "error_\(code)", error: "Error")
            fail?(error)
            return
        }
        
        if let value = response.result.value {
            success(value as AnyObject)
        } else {
            fail?(MError(code: "Timeout or no response data, please try again!", error: "Timeout or no response data, please try again!"))
        }
    }
}
