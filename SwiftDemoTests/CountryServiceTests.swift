//
//  CountryServiceTests.swift
//  SwiftDemoTests
//
//  Created by Vijay Kumar Baswana on 19/06/18.
//  Copyright © 2018 Vijay Kumar Baswana. All rights reserved.
//

import XCTest
@testable import SwiftDemo
import SwiftyJSON

class CountryServiceTests: XCTestCase {
    
    var service: CountryDataService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = CountryDataService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service = nil
        super.tearDown()
    }
    
    func testIfServiceIsSuccessful() {
        let expectation = XCTestExpectation(description: "Fetch country info")
        
        service.fetchCountryInfo { (isSuccess, _, _) in
            XCTAssert(isSuccess)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testResponseValidity() {
        let expectation = XCTestExpectation(description: "Fetch country info")

        service.fetchCountryInfo { (isSuccess, json, err) in
            XCTAssert(json != JSON.null)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testServicePerformance() {
        // This will measure time taken by service call and converting to JSON object using SwiftyJson.
        self.measure {
            let expectation = XCTestExpectation(description: "Fetch country info")
            service.fetchCountryInfo { (_, _, _) in
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 10.0)
        }
    }
}
