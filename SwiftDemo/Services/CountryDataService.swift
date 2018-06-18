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

    func fetchCountryInfo(completion: @escaping (Bool, JSON?, Error?) -> Void) {
        Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
            .responseString { response in
                switch response.result {
                case .success:
                    completion(true, JSON(response.result.value ?? Constants.emptyString), nil)
                    break
                case .failure:
                    completion(false, nil, response.error)
                    break
                }
            }
    }
}
