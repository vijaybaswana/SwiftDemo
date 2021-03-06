//
//  AboutCountry.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SwiftyJSON

class AboutCountry {

    var title: String?
    var rows = [CountryAttributes]()
    
    init(params: JSON) {
        title = params["title"].string
        if let items = params["rows"].array {
            for item in items {
                rows.append(CountryAttributes(params: item))
            }
        }
    }
}
