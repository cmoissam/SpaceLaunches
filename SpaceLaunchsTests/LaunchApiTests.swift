//
//  LaunchApiTests.swift
//  SpaceLaunchsTests
//
//  Created by Issam Lanouari on 30/01/2021.
//

import XCTest
@testable import SpaceLaunchs

class SpaceLaunchsTests: XCTestCase {
    func test_getLaunchsData_success() {
        let expectation = XCTestExpectation(description: "Get remote data completion")
        let launchsApi = LaunchsApi()
        launchsApi.getLaunchs { launchs, error in
            XCTAssertNil(error)
            XCTAssertNotNil(launchs)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
