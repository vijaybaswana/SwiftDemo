//
//  CountryDataViewModelTests.swift
//  SwiftDemoTests
//
//  Created by Vijay Kumar Baswana on 19/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import XCTest
@testable import SwiftDemo

class CountryDataViewModelTests: XCTestCase {
    
    var viewModel: CountryDataViewModel!
    
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
        super.tearDown()
    }
    
    func testTitleValidity() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(self.viewModel.getTitle() != Constants.emptyString && self.viewModel.getNumberOfRows() > 0)
    }
    
    func testAttributesValidity() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(self.viewModel.getNumberOfRows() > 0)
    }
}
