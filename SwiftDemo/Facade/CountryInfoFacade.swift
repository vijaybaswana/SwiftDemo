//
//  CountryInfoFacade.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountryInfoFacade: NSObject {
    
    func fetchData(completion: @escaping (Bool, JSON?, Error?) -> Void) {
        CountryDataService().fetchCountryInfo(completion: completion)
    }
}
