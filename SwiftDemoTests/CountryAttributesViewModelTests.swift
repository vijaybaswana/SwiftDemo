//
//  CountryAttributesViewModelTests.swift
//  SwiftDemoTests
//
//  Created by Vijay Kumar Baswana on 19/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import XCTest
@testable import SwiftDemo

class CountryAttributesViewModelTests: XCTestCase {
    
    var viewModel: CountryDataViewModel!
    var attributes: [CountryAttributesViewModel]?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CountryDataViewModel()
        let expectation = XCTestExpectation(description: "Fetch country info")
        
        viewModel.fetchCountryInfo { (isSuccess, err) in
            expectation.fulfill()
        }
        // wait for the API call to finish with a timeout of 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        attributes = nil
        super.tearDown()
    }
    
    func testAttributesValidity() {
        // test if all the country attributes received as part of response has either title or description
        guard let attributes = viewModel.getAttributesViewModels() else {
            XCTAssertNotNil(viewModel.getAttributesViewModels())
            return
        }
        for item in attributes {
            XCTAssert(item.isValid())
        }
    }
    
    func testIfAttributesHaveUrl() {
        guard let attributes = viewModel.getAttributesViewModels() else {
            XCTAssertNotNil(viewModel.getAttributesViewModels())
            return
        }
        for item in attributes {
            XCTAssertNotNil(item.getImageUrl())
        }
    }
}
