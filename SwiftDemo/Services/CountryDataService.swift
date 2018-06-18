//
//  CountryDataService.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct ServiceConstants {
    static let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

class CountryDataService: NSObject {

    func fetchCountryInfo(completion: @escaping (Bool, JSON?, Error?) -> Void) {
        if shouldAllowCaching() {
            // this will allow response to be cached
            Alamofire.request(ServiceConstants.url, headers: getHeaders())
                .responseData { (response) in
                    self.handleResult(response: response, completion: completion)
            }
        } else {
            // will ignore cached data if any
            Alamofire.SessionManager.default
                .requestWithoutCache(ServiceConstants.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: getHeaders())
                .responseData { (response) in
                    self.handleResult(response: response, completion: completion)
            }
        }
    }
    
    private func handleResult(response: DataResponse<Data>, completion: @escaping (Bool, JSON?, Error?) -> Void) {
        // method will process the response received and pass it through completion block
        switch response.result {
        case .success:
            if let data = response.data, let responseStrInISOLatin = String(data: data, encoding: .isoLatin1) {
                guard let modifiedDataInUTF8Format = responseStrInISOLatin.data(using: .utf8) else {
                    print("could not convert data to UTF-8 format")
                    completion(false, nil, response.error)
                    return
                }
                completion(true, JSON(modifiedDataInUTF8Format), nil)
            }
            break
        case .failure:
            completion(false, nil, response.error)
            break
        }
    }
    
    private func getHeaders() -> HTTPHeaders {
        return [
            "Accept": "application/json"
        ]
    }
    
    private func shouldAllowCaching() ->  Bool {
        return false
    }
}

extension Alamofire.SessionManager {
    @discardableResult
    // Method will return an object of request with cache policy ignored.
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
            urlRequest.timeoutInterval = 10
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            print(error)
            return request(URLRequest(url: URL(string: ServiceConstants.url)!))
        }
    }
}
