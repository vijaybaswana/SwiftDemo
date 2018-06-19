//
//  CountryAttributesViewModel.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import UIKit

class CountryAttributesViewModel: BaseViewModel {

    private var title: String?
    private var attrDescription: String?
    private var imageUrl: String?
    
    init(attributes: CountryAttributes) {
        title = attributes.title
        attrDescription = attributes.attributeDescription
        imageUrl = attributes.imageUrl
    }
    
    func getTitle() -> String {
        return title ?? Constants.emptyString
    }
    
    func getDescription() -> String {
        return attrDescription ?? Constants.emptyString
    }
    
    func getImageUrl() -> String? {
        return imageUrl
    }
    
    func isValid() -> Bool {
        return title != nil || attrDescription != nil
    }
}
