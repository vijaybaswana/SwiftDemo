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
    
    private var response: AboutCountry?
    private var attributes: [CountryAttributesViewModel]?
    
    
    /// Method will fetch information related to country
    ///
    /// - Parameter completion: this will have 2 params, Bool - can be used to check if the API call was successful. Error - will inform about the failure
    func fetchCountryInfo(completion: @escaping BaseViewModelCompletionBlock) {
        CountryInfoFacade().fetchData { (isSuccess, countryInfo, err) in
            self.resetResponse()
            if isSuccess {
                guard let info = countryInfo else {
                    completion(false, err)
                    return
                }
                // convert response into model objects
                self.response = AboutCountry(params: info)
                self.prepareAttributesViewModel()
            }
            completion(isSuccess, err)
        }
    }
    
    private func prepareAttributesViewModel() {
        guard let items = response?.rows else {
            resetResponse()
            return
        }
        for item in items {
            // ignore item if title and description both are nil
            guard item.title != nil || item.attributeDescription != nil else {
                continue
            }
            if attributes == nil {
                attributes = [CountryAttributesViewModel]()
            }
            attributes?.append(CountryAttributesViewModel(attributes: item))
        }
    }
    
    private func resetResponse() {
        response = nil
        attributes = nil
    }
    
    func getTitle() -> String {
        return response?.title ?? Constants.emptyString
    }
    
    func getAttributesViewModels() -> [CountryAttributesViewModel]? {
        return attributes
    }
    
    func getNumberOfSections() -> Int {
        return attributes == nil ? 0 : 1
    }
    
    func getNumberOfRows() -> Int {
        return attributes?.count ?? 0
    }
}
