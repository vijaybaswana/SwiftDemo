//
//  CountryDataViewModel.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountryDataViewModel: BaseViewModel {
    
    func fetchCountryInfo(completion: @escaping BaseViewModelCompletionBlock) {
        CountryInfoFacade().fetchData { (isSuccess, countryInfo, err) in
            completion(isSuccess, err)
        }
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumberOfRows() -> Int {
        return 1
    }
}
