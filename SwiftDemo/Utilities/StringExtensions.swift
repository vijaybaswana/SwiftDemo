//
//  StringExtensions.swift
//  SwiftDemo
//
//  Created by Vijay Kumar Baswana on 18/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import Foundation

extension String {
    
    /// Method will return localized text from localizable.strings file
    func localizedText() -> String {
        return NSLocalizedString(self, comment: Constants.emptyString)
    }
}
