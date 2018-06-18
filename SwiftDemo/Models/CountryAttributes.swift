//
//  CountryAttributes.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountryAttributes {
    
    var title: String?
    var attributeDescription: String?
    var imageUrl: String?
    
    init(params: JSON) {
        title = params["title"].string
        attributeDescription = params["description"].string
        imageUrl = params["imageHref"].string
    }

}
