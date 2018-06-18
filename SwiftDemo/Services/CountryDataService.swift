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

class CountryDataService: NSObject {
    
    private let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    func fetchCountryInfo(completion: @escaping (Bool, JSON?, Error?) -> Void) {
        Alamofire.request(url, headers: getHeaders())
        .responseData { (response) in
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
    }
    
    private func getHeaders() -> HTTPHeaders {
        return [
            "Accept": "application/json"
        ]
    }
}
