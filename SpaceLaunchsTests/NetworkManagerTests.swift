//
//  NetworkManagerTests.swift
//  SpaceLaunchsTests
//
//  Created by Issam Lanouari on 30/01/2021.
//

import XCTest
@testable import SpaceLaunchs

class NetworkManagerTest: XCTestCase {

    func test_request_shouldExecuteCompletionOnArbitraryQueue() {
      let expectation = XCTestExpectation(description: "Web service completion")
      NetworkManager.request(fakeResource()) { (_, _) in
        XCTAssertEqual(OperationQueue.current?.underlyingQueue, DispatchQueue.main)
        expectation.fulfill()
      }

      wait(for: [expectation], timeout: 5.0)
    }

    func test_requestWithMainCompletionQueue_shouldExecuteCompletionOnMainQueue() {
      let expectation = XCTestExpectation(description: "Web service completion")
      NetworkManager.request(fakeResource(), completionQueue: DispatchQueue.main) { (_, _) in
        //Then
        XCTAssertEqual(OperationQueue.current?.underlyingQueue, DispatchQueue.main)
        expectation.fulfill()
      }

      wait(for: [expectation], timeout: 5.0)
    }

    // MARK: - Helpers

    /// Not a valid resource but we just want to test completion closure
    private func fakeResource() -> Resource<String> {
      return Resource<String>(
        url: URL(string: "https://google.com")!,
        method: HTTPMethod.GET,
        successStatusCode: 200
      )
    }
}
